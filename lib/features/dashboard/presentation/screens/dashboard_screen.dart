import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../../../core/utils/format.dart';
import '../../data/models/hg_event.dart';

class TimelineList extends StatelessWidget {
  const TimelineList({
    super.key,
    required this.events,
    this.limit = 6,
  });

  final List<HgEvent> events;
  final int limit;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: AppColors.surface.withAlpha((0.85 * 255).round()),
          borderRadius: BorderRadius.circular(AppSpacing.radius24),
          border: Border.all(color: AppColors.line),
        ),
        child: Text(
          'No events yet…',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.inkSubtle),
        ),
      );
    }

    // keep newest events (limit)
    final shown = events.length > limit
        ? events.sublist(events.length - limit)
        : events;

    // show newest first
    final items = shown.reversed.toList(growable: false);

    return Column(
      children: [
        for (final e in items) ...[
          _TimelineItem(event: e),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.event});

  final HgEvent event;

  @override
  Widget build(BuildContext context) {
    final tag = _tagStyle(event.kind);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s14),
      decoration: BoxDecoration(
        color: AppColors.surface.withAlpha((0.85 * 255).round()),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: tag.bg,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: tag.border),
            ),
            child: Text(
              event.kind.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // message
          Expanded(
            child: Text(
              event.msg,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // time
          Text(
            fmtTimeFromEpochSec(event.ts),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.inkSubtle),
          ),
        ],
      ),
    );
  }
}

_Tag _tagStyle(String kind) {
  final k = kind.toLowerCase();

  if (k.contains('risk')) {
    return _Tag(
      bg: AppColors.rose.withAlpha((0.14 * 255).round()),
      border: AppColors.rose.withAlpha((0.50 * 255).round()),
    );
  }

  if (k.contains('warn')) {
    return _Tag(
      bg: AppColors.lemon.withAlpha((0.16 * 255).round()),
      border: AppColors.lemon.withAlpha((0.55 * 255).round()),
    );
  }

  if (k.contains('break')) {
    return _Tag(
      bg: AppColors.mint.withAlpha((0.14 * 255).round()),
      border: AppColors.mint.withAlpha((0.55 * 255).round()),
    );
  }

  if (k.contains('noise')) {
    return _Tag(
      bg: AppColors.coral.withAlpha((0.14 * 255).round()),
      border: AppColors.coral.withAlpha((0.55 * 255).round()),
    );
  }

  // presence / info default
  return _Tag(
    bg: AppColors.chartPurple.withAlpha((0.14 * 255).round()),
    border: AppColors.chartPurple.withAlpha((0.50 * 255).round()),
  );
}

class _Tag {
  _Tag({required this.bg, required this.border});
  final Color bg;
  final Color border;
}
