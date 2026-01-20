import 'package:flutter/material.dart';
import 'formatters.dart';

class RiskBadge extends StatelessWidget {
  const RiskBadge({super.key, required this.cli});
  final int cli;

  @override
  Widget build(BuildContext context) {
    final label = riskLabel(cli);

    Color border;
    if (label == 'Healthy') border = Theme.of(context).colorScheme.secondary;
    else if (label == 'Accumulating') border = const Color(0xFFFFCC00);
    else border = const Color(0xFFFF4D6D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border.withOpacity(0.6)),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
      ),
    );
  }
}
