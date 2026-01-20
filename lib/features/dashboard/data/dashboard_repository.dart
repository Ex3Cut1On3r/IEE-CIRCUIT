import 'dart:async';
import '../../../core/network/endpoints.dart';
import '../../../core/network/ws_client.dart';
import 'dashboard_api.dart';
import 'models/hg_event.dart';
import 'models/hg_history_point.dart';
import 'models/hg_latest.dart';
import 'models/hg_ws_payload.dart';

class DashboardRepository {
  DashboardRepository({
    required DashboardApi api,
    WsClient? ws,
  })  : _api = api,
        _ws = ws ?? WsClient(path: Endpoints.ws);

  final DashboardApi _api;
  final WsClient _ws;

  Stream<HgWsPayload> wsStream() async* {
    await _ws.connect();
    yield* _ws.stream.map((m) => HgWsPayload.fromJson(m));
  }

  bool get wsConnected => _ws.isConnected;

  Future<void> closeWs() => _ws.close();

  Future<HgLatest> latest() => _api.fetchLatest();
  Future<List<HgHistoryPoint>> history() => _api.fetchHistory();
  Future<List<HgEvent>> events() => _api.fetchEvents();
}
