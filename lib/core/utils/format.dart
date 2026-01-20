String fmtDuration(int sec) {
  sec = sec < 0 ? 0 : sec;
  final m = sec ~/ 60;
  final s = sec % 60;

  if (m >= 60) {
    final h = m ~/ 60;
    final mm = m % 60;
    return '${h}h ${mm}m';
  }
  return '${m}m ${s}s';
}

String fmtTimeFromEpochSec(int ts) {
  if (ts <= 0) return '—';
  final d = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}
