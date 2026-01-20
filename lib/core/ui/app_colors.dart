import 'package:flutter/material.dart';

class AppColors {
  // Base
  static const Color sun = Color(0xFFFFE08A);     // warm highlight
  static const Color lime = Color(0xFFB9F46B);    // soft lime accent
  static const Color chartRed = Color(0xFFFF4D6D); // chart red (alias to rose is fine)

  static const Color bg = Color(0xFFF3F0E8);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color ink = Color(0xFF121417);
  static const Color inkSubtle = Color(0xFF6C727A);

  // Lines / shadows
  static const Color line = Color(0xFFE6E0D6);
  static const Color shadow = Color(0x1A000000); // ~10% black

  // Brand + accents (names used across your widgets)
  static const Color coral = Color(0xFFFF6B5C);
  static const Color mint = Color(0xFF2EE59D);
  static const Color lemon = Color(0xFFFFCC00);
  static const Color rose = Color(0xFFFF4D6D);
  static const Color sky = Color(0xFF7AA7FF);
  static const Color chartPurple = Color(0xFF7C5CFF);

  // ---------
  // Backward-compatible aliases (so old/new code both compile)
  // ---------
  static const Color panel = surface;
  static const Color text = ink;
  static const Color muted = inkSubtle;

  static const Color brand = coral;
  static const Color ok = mint;
  static const Color warn = lemon;
  static const Color danger = rose;
}
