import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/notification_service.dart';
import '../../data/dashboard_api.dart';
import '../../data/dashboard_repository.dart';
import '../../data/models/hg_event.dart';
import '../../data/models/hg_history_point.dart';
import 'dashboard_state.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final api = DashboardApi();
  return DashboardRepository(api: api);
});

final dashboardControllerProvider =
StateNotifierProvider<DashboardController, DashboardState>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  final c = DashboardController(repo);
  ref.onDispose(c.dispose);
  return c;
});

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController(this._repo) : super(DashboardState.initial()) {
    _boot();
  }

  final DashboardRepository _repo;
  StreamSubscription? _wsSub;
  Timer? _pollTimer;

  bool _sentSittingAlertThisStreak = false;

  Future<void> _handleSittingNotification(int occ, int sitSec) async {
    // Reset when user leaves / not occupied (new streak can trigger again)
    if (occ == 0 || sitSec <= 5) {
      _sentSittingAlertThisStreak = false;
      return;
    }

    // Notify once per sitting streak when reaching 60s
    if (occ == 1 && sitSec >= 60 && !_sentSittingAlertThisStreak) {
      _sentSittingAlertThisStreak = true;
      await NotificationService.showSittingTooLong(sitSec: sitSec);
    }
  }

  Future<void> _boot() async {
    // initial load
    await refresh();

    // start WS
    _wsSub = _repo.wsStream().listen(
          (payload) async {
        final latest = payload.latest;
        final wsEvents = payload.events;

        // ✅ Trigger sitting notification based on latest data
        await _handleSittingNotification(latest.occ, latest.sitSec);

        // append latest into history-like list (client-side)
        final newPoint = HgHistoryPoint(
          ts: latest.ts,
          cli: latest.cli,
          temp: latest.temp,
          hum: latest.hum,
          dist: latest.dist,
          noise: latest.noise,
          occ: latest.occ,
          sitSec: latest.sitSec,
          breaks: latest.breaks,
        );

        final hist = <HgHistoryPoint>[...state.history, newPoint];
        final trimmed =
        (hist.length > 600) ? hist.sublist(hist.length - 600) : hist;

        state = state.copyWith(
          wsLive: true,
          latest: latest,
          history: trimmed,
          events: _mergeEvents(state.events, wsEvents),
          loading: false,
          error: null,
        );
      },
      onError: (_) {
        state = state.copyWith(wsLive: false);
      },
      onDone: () {
        state = state.copyWith(wsLive: false);
      },
      cancelOnError: false,
    );

    // polling fallback (in case WS is blocked by network)
    _pollTimer = Timer.periodic(const Duration(seconds: 15), (_) async {
      if (!mounted) return;
      if (!state.wsLive) {
        await refresh(silent: true);
      }
    });
  }

  /// ✅ Correctly typed merge => returns List<HgEvent>
  List<HgEvent> _mergeEvents(List<HgEvent> oldEvents, List<HgEvent> newEvents) {
    final combined = <HgEvent>[...oldEvents, ...newEvents];

    final seen = <String>{};
    final uniq = <HgEvent>[];

    for (final e in combined) {
      final key = '${e.ts}|${e.kind}|${e.msg}';
      if (seen.add(key)) uniq.add(e);
    }

    uniq.sort((a, b) => a.ts.compareTo(b.ts));

    if (uniq.length > 50) {
      return uniq.sublist(uniq.length - 50);
    }
    return uniq;
  }

  Future<void> refresh({bool silent = false}) async {
    try {
      if (!silent) {
        state = state.copyWith(loading: true, error: null);
      }

      final latest = await _repo.latest();
      final history = await _repo.history();
      final events = await _repo.events();

      // ✅ Trigger sitting notification even when WS is not live
      await _handleSittingNotification(latest.occ, latest.sitSec);

      state = state.copyWith(
        loading: false,
        latest: latest,
        history: history,
        events: events,
        error: null,
        wsLive: _repo.wsConnected,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Failed to load data. Check network / server.',
        wsLive: false,
      );
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _wsSub?.cancel();
    _repo.closeWs();
    super.dispose();
  }
}
