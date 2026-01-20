import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/endpoints.dart';
import 'models/hg_event.dart';
import 'models/hg_history_point.dart';
import 'models/hg_latest.dart';

class DashboardApi {
  DashboardApi({Dio? dio}) : _dio = dio ?? ApiClient.instance.dio;
  final Dio _dio;

  Future<HgLatest> fetchLatest() async {
    final r = await _dio.get(Endpoints.latest, options: Options(responseType: ResponseType.json));
    return HgLatest.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  Future<List<HgHistoryPoint>> fetchHistory() async {
    final r = await _dio.get(Endpoints.history, options: Options(responseType: ResponseType.json));
    final list = (r.data is List) ? (r.data as List) : <dynamic>[];
    return list
        .whereType<Map>()
        .map((e) => HgHistoryPoint.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<List<HgEvent>> fetchEvents() async {
    final r = await _dio.get(Endpoints.events, options: Options(responseType: ResponseType.json));
    final list = (r.data is List) ? (r.data as List) : <dynamic>[];
    return list
        .whereType<Map>()
        .map((e) => HgEvent.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
