import 'hg_event.dart';
import 'hg_latest.dart';

class HgWsPayload {
  HgWsPayload({required this.latest, required this.events});

  final HgLatest latest;
  final List<HgEvent> events;

  factory HgWsPayload.fromJson(Map<String, dynamic> j) {
    final latestMap = (j['latest'] is Map<String, dynamic>) ? j['latest'] as Map<String, dynamic> : j;
    final evList = (j['events'] is List) ? (j['events'] as List) : const [];

    return HgWsPayload(
      latest: HgLatest.fromJson(latestMap),
      events: evList
          .whereType<Map>()
          .map((e) => HgEvent.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}
