import 'package:flutter/material.dart';

class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.values,
    required this.color,
    this.minY,
    this.maxY,
  });

  final List<double> values;
  final Color color;
  final double? minY;
  final double? maxY;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparkPainter(values, color, minY, maxY),
      size: const Size(double.infinity, 64),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter(this.values, this.color, this.minY, this.maxY);

  final List<double> values;
  final Color color;
  final double? minY;
  final double? maxY;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = color;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black.withOpacity(.06);

    // subtle grid lines
    for (int i = 1; i <= 3; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), bg);
    }

    double lo = minY ?? values.reduce((a, b) => a < b ? a : b);
    double hi = maxY ?? values.reduce((a, b) => a > b ? a : b);
    if (hi - lo < 0.0001) hi = lo + 1;

    final path = Path();
    for (int i = 0; i < values.length; i++) {
      final x = size.width * (i / (values.length - 1));
      final t = (values[i] - lo) / (hi - lo);
      final y = (size.height - 6) - t * (size.height - 12);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}
