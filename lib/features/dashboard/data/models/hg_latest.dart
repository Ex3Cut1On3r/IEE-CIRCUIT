class HgLatest {
  HgLatest({
    required this.ts,
    required this.device,
    required this.temp,
    required this.hum,
    required this.dist,
    required this.noise,
    required this.occ,
    required this.cli,
    required this.sitSec,
    required this.breaks,
    required this.mmState,
    required this.moveDistCm,
    required this.moveE,
    required this.statDistCm,
    required this.statE,
    required this.detDistCm,
    required this.breathBpm,
    required this.breathConf,
    required this.breathAlert,
  });

  final int ts;
  final String device;
  final double temp;
  final double hum;
  final int dist; // mm
  final int noise; // 0..100
  final int occ; // 0/1
  final int cli; // 0..100
  final int sitSec;
  final int breaks;

  final int mmState;
  final int moveDistCm;
  final int moveE;
  final int statDistCm;
  final int statE;
  final int detDistCm;
  final double breathBpm;
  final int breathConf;
  final int breathAlert;

  factory HgLatest.empty() => HgLatest(
    ts: 0,
    device: '—',
    temp: 0,
    hum: 0,
    dist: 0,
    noise: 0,
    occ: 0,
    cli: 0,
    sitSec: 0,
    breaks: 0,
    mmState: 0,
    moveDistCm: 0,
    moveE: 0,
    statDistCm: 0,
    statE: 0,
    detDistCm: 0,
    breathBpm: 0,
    breathConf: 0,
    breathAlert: 0,
  );

  factory HgLatest.fromJson(Map<String, dynamic> j) {
    double _d(dynamic v) => (v is num) ? v.toDouble() : 0.0;
    int _i(dynamic v) => (v is num) ? v.toInt() : 0;

    return HgLatest(
      ts: _i(j['ts']),
      device: (j['device'] ?? '—').toString(),
      temp: _d(j['temp']),
      hum: _d(j['hum']),
      dist: _i(j['dist']),
      noise: _i(j['noise']),
      occ: _i(j['occ']),
      cli: _i(j['cli']),
      sitSec: _i(j['sitSec']),
      breaks: _i(j['breaks']),
      mmState: _i(j['mmState']),
      moveDistCm: _i(j['moveDistCm']),
      moveE: _i(j['moveE']),
      statDistCm: _i(j['statDistCm']),
      statE: _i(j['statE']),
      detDistCm: _i(j['detDistCm']),
      breathBpm: _d(j['breathBpm']),
      breathConf: _i(j['breathConf']),
      breathAlert: _i(j['breathAlert']),
    );
  }
}
