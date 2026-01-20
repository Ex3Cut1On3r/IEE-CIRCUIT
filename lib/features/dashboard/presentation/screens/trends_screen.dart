import 'package:flutter/material.dart';
import '../../../../core/ui/hg_background.dart';
import '../../../../core/ui/app_spacing.dart';

class TrendsScreen extends StatelessWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HgBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.s20),
            children: [
              Text('Trends', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'In the next step, we’ll add: daily/weekly summaries, thresholds, and “heat/noise load” explanations.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              // You can expand this screen later (histogram, daily aggregation, etc.)
              _PlaceholderCard(text: 'Coming next: 24h timeline + trend insights.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  const _PlaceholderCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withOpacity(.08)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
