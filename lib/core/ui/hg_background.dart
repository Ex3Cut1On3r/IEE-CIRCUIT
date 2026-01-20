import 'package:flutter/material.dart';
import 'app_colors.dart';

class HgBackground extends StatelessWidget {
  const HgBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // avoid withOpacity deprecation:
    Color a(Color c, double opacity) => c.withAlpha((opacity * 255).round());

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                a(AppColors.brand, 0.18),
                a(AppColors.sun, 0.35),
                a(AppColors.bg, 1.0),
              ],
            ),
          ),
        ),

        // soft blobs
        Positioned(
          left: -90,
          top: -80,
          child: _Blob(color: a(AppColors.brand, 0.20), size: 220),
        ),
        Positioned(
          right: -80,
          top: 120,
          child: _Blob(color: a(AppColors.sky, 0.18), size: 200),
        ),
        Positioned(
          left: 40,
          bottom: -120,
          child: _Blob(color: a(AppColors.lime, 0.14), size: 260),
        ),

        SafeArea(child: child),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 60,
            spreadRadius: 10,
            color: color,
          ),
        ],
      ),
    );
  }
}
