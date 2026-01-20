import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../data/models/hg_event.dart';

class TimelineList extends StatelessWidget {
  const TimelineList({super.key, required this.events});

  final List<HgEvent> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Text(
          "No events yet…",
          style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700),
        ),
      );
    }

    final items = events.length > 25 ? events.sublist(events.length - 25) : events;

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s10),
      itemBuilder: (context, i) {
        final e = items[items.length - 1 - i]; // newest first
        final t = DateTime.fromMillisecondsSinceEpoch(e.ts * 1000);
        final time = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}";

        final accent = _accentFor(e.kind);

        return Container(
          padding: const EdgeInsets.all(AppSpacing.s14),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accent.withAlpha((0.22 * 255).round())),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withAlpha((0.60 * 255).round()),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.kind.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e.msg,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Text(
                time,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _accentFor(String kind) {
    switch (kind.toLowerCase()) {
      case "risk":
        return AppColors.danger;
      case "warn":
        return AppColors.warn;
      case "break":
        return AppColors.ok;
      case "noise":
        return AppColors.danger;
      case "presence":
        return AppColors.sky;
      default:
        return AppColors.brand;
    }
  }
}
