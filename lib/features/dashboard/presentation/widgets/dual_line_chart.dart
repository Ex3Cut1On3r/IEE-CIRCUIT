import 'package:flutter/material.dart';

class DualLineChart extends StatelessWidget {
  const DualLineChart({
    super.key,
    required this.pointsA,
    required this.pointsB,
    required this.colorA,
    required this.colorB,
  });

  final List<double> pointsA; // CLI
  final List<double> pointsB; // Noise
  final Color colorA;
  final Color colorB;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DualPainter(pointsA, pointsB, colorA, colorB),
      size: const Size(double.infinity, 220),
    );
  }
}

class _DualPainter extends CustomPainter {
  _DualPainter(this.a, this.b, this.colorA, this.colorB);

  final List<double> a;
  final List<double> b;
  final Color colorA;
  final Color colorB;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black.withOpacity(.08);

    final fill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(.55);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      border,
    );

    // grid
    final grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black.withOpacity(.06);

    for (int i = 1; i <= 4; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    if (a.length < 2 || b.length < 2) return;

    // charts assume 0..100 range (CLI and Noise)
    Path pathOf(List<double> v) {
      final p = Path();
      for (int i = 0; i < v.length; i++) {
        final x = size.width * (i / (v.length - 1));
        final y = size.height - (v[i].clamp(0, 100) / 100.0) * size.height;
        if (i == 0) p.moveTo(x, y);
        else p.lineTo(x, y);
      }
      return p;
    }

    final pA = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..color = colorA;

    final pB = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = colorB.withOpacity(.95);

    canvas.drawPath(pathOf(a), pA);
    canvas.drawPath(pathOf(b), pB);
  }

  @override
  bool shouldRepaint(covariant _DualPainter oldDelegate) =>
      oldDelegate.a != a || oldDelegate.b != b;
}
