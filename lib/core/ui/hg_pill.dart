import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class HgPill extends StatelessWidget {
  const HgPill({
    super.key,
    required this.text,
    this.accent = AppColors.coral,
  });

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final bg = accent.withAlpha((0.14 * 255).round());

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s8,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withAlpha((0.30 * 255).round())),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}
