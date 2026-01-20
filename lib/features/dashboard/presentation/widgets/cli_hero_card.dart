import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../../../core/ui/hg_card.dart';

class CliHeroCard extends StatelessWidget {
  const CliHeroCard({
    super.key,
    required this.cli,
    required this.trendLabel,
    required this.riskLabel,
    required this.suggestion,
    required this.isLive,
  });

  final int cli;
  final String trendLabel;
  final String riskLabel;
  final String suggestion;
  final bool isLive;

  Color get _riskColor {
    if (cli < 30) return AppColors.mint;
    if (cli < 60) return AppColors.lemon;
    return AppColors.rose;
  }

  @override
  Widget build(BuildContext context) {
    return HgCard(
      padding: const EdgeInsets.all(AppSpacing.s20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Cardiac Load Index (CLI)',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _riskColor.withOpacity(.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _riskColor.withOpacity(.35)),
                ),
                child: Text(
                  riskLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  '$cli',
                  key: ValueKey(cli),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  trendLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.inkSubtle,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                isLive ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                color: isLive ? AppColors.mint : AppColors.inkSubtle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (cli.clamp(0, 100)) / 100.0,
              minHeight: 10,
              backgroundColor: Colors.black.withOpacity(.05),
              valueColor: AlwaysStoppedAnimation<Color>(_riskColor),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            suggestion,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.inkSubtle),
          ),
        ],
      ),
    );
  }
}
