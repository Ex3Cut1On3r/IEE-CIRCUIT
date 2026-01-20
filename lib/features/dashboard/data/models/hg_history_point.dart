class HgHistoryPoint {
  HgHistoryPoint({
    required this.ts,
    required this.cli,
    required this.temp,
    required this.hum,
    required this.dist,
    required this.noise,
    required this.occ,
    required this.sitSec,
    required this.breaks,
  });

  final int ts;
  final int cli;
  final double temp;
  final double hum;
  final int dist;
  final int noise;
  final int occ;
  final int sitSec;
  final int breaks;

  factory HgHistoryPoint.fromJson(Map<String, dynamic> j) {
    double _d(dynamic v) => (v is num) ? v.toDouble() : 0.0;
    int _i(dynamic v) => (v is num) ? v.toInt() : 0;

    return HgHistoryPoint(
      ts: _i(j['ts']),
      cli: _i(j['cli']),
      temp: _d(j['temp']),
      hum: _d(j['hum']),
      dist: _i(j['dist']),
      noise: _i(j['noise']),
      occ: _i(j['occ']),
      sitSec: _i(j['sitSec']),
      breaks: _i(j['breaks']),
    );
  }
}
