import 'package:flutter/material.dart';

ThemeData buildHeartGuardTheme() {
  const bg = Color(0xFF0B1020);
  const panel = Color(0x141FFFFFF); // 8% white-ish (approx)
  const text = Color(0xFFE8ECFF);

  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7C5CFF),
      secondary: Color(0xFF2EE59D),
      surface: panel,
      onSurface: text,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w800),
      titleMedium: TextStyle(fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(height: 1.25),
    ),
  );

  return base.copyWith(
    cardTheme: CardTheme(
      color: const Color(0x12FFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}
