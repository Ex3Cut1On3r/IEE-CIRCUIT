import 'package:intl/intl.dart';

String fmtTimeFromUnix(int ts) {
  if (ts <= 0) return '—';
  final d = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
  return DateFormat('HH:mm:ss').format(d);
}

String fmtDuration(int sec) {
  if (sec < 0) sec = 0;
  final m = sec ~/ 60;
  final s = sec % 60;
  if (m >= 60) {
    final h = m ~/ 60;
    final mm = m % 60;
    return '${h}h ${mm}m';
  }
  return '${m}m ${s}s';
}

String riskLabel(int cli) {
  if (cli < 30) return 'Healthy';
  if (cli < 60) return 'Accumulating';
  return 'High Risk';
}
