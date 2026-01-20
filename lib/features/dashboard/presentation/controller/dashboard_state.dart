import '../../data/models/hg_event.dart';
import '../../data/models/hg_history_point.dart';
import '../../data/models/hg_latest.dart';

class DashboardState {
  DashboardState({
    required this.loading,
    required this.wsLive,
    required this.latest,
    required this.history,
    required this.events,
    this.error,
  });

  final bool loading;
  final bool wsLive;
  final HgLatest latest;
  final List<HgHistoryPoint> history;
  final List<HgEvent> events;
  final String? error;

  DashboardState copyWith({
    bool? loading,
    bool? wsLive,
    HgLatest? latest,
    List<HgHistoryPoint>? history,
    List<HgEvent>? events,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      wsLive: wsLive ?? this.wsLive,
      latest: latest ?? this.latest,
      history: history ?? this.history,
      events: events ?? this.events,
      error: error,
    );
  }

  factory DashboardState.initial() => DashboardState(
    loading: true,
    wsLive: false,
    latest: HgLatest.empty(),
    history: const [],
    events: const [],
    error: null,
  );
}
