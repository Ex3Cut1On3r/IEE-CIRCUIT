class HgEvent {
  HgEvent({required this.ts, required this.kind, required this.msg});

  final int ts;
  final String kind;
  final String msg;

  factory HgEvent.fromJson(Map<String, dynamic> j) {
    int _i(dynamic v) => (v is num) ? v.toInt() : 0;
    return HgEvent(
      ts: _i(j['ts']),
      kind: (j['kind'] ?? '').toString(),
      msg: (j['msg'] ?? '').toString(),
    );
  }
}
