import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../../../core/ui/hg_background.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/timeline_list.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    final latest = state.latest;

    return HgBackground(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.s10),
            Row(
              children: [
                const Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.text,
                  ),
                ),
                const Spacer(),
                _LivePill(live: state.wsLive),
              ],
            ),
            const SizedBox(height: AppSpacing.s16),

            // CLI hero
            _HeroCard(
              cli: latest.cli,
              sitSec: latest.sitSec,
              occ: latest.occ,
              noise: latest.noise,
            ),

            const SizedBox(height: AppSpacing.s14),

            // sensors row
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: "Temperature",
                    value: "${latest.temp.toStringAsFixed(1)}",
                    unit: "°C",
                    accent: AppColors.brand,
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: _MetricCard(
                    title: "Humidity",
                    value: "${latest.hum.round()}",
                    unit: "%",
                    accent: AppColors.sky,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s12),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: "Distance",
                    value: "${latest.dist}",
                    unit: "mm",
                    accent: AppColors.lime,
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: _MetricCard(
                    title: "Noise",
                    value: "${latest.noise}",
                    unit: "/100",
                    accent: AppColors.danger,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s16),

            const Text(
              "Timeline",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: AppSpacing.s10),

            Expanded(
              child: TimelineList(events: state.events),
            ),
          ],
        ),
      ),
    );
  }
}

class _LivePill extends StatelessWidget {
  const _LivePill({required this.live});
  final bool live;

  @override
  Widget build(BuildContext context) {
    final bg = live ? AppColors.ok : AppColors.warn;
    final label = live ? "LIVE" : "POLLING";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg.withAlpha((0.18 * 255).round()),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: bg.withAlpha((0.28 * 255).round())),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.text,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.cli,
    required this.sitSec,
    required this.occ,
    required this.noise,
  });

  final int cli;
  final int sitSec;
  final int occ;
  final int noise;

  String _riskLabel(int cli) {
    if (cli < 30) return "Healthy";
    if (cli < 60) return "Accumulating";
    return "High Risk";
  }

  @override
  Widget build(BuildContext context) {
    final risk = _riskLabel(cli);
    final accent = (cli >= 70)
        ? AppColors.danger
        : (cli >= 60)
        ? AppColors.warn
        : AppColors.ok;

    String fmtDur(int s) {
      final m = s ~/ 60;
      final sec = s % 60;
      if (m >= 60) return "${m ~/ 60}h ${m % 60}m";
      return "${m}m ${sec}s";
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Cardiac Load Index",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withAlpha((0.16 * 255).round()),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  risk,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$cli",
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  " / 100",
                  style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Sitting: ${fmtDur(sitSec)}",
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Presence: ${occ == 1 ? "YES" : "NO"} • Noise: $noise/100",
                    style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (cli.clamp(0, 100)) / 100.0,
              minHeight: 10,
              backgroundColor: const Color(0xFFF1F1F1),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.accent,
  });

  final String title;
  final String value;
  final String unit;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 46,
            decoration: BoxDecoration(
              color: accent.withAlpha((0.55 * 255).round()),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(unit, style: const TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
