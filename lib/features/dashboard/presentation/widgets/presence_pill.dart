import 'package:flutter/material.dart';

class PresencePill extends StatelessWidget {
  const PresencePill({
    super.key,
    required this.wsLive,
    required this.occ,
    required this.device,
    required this.lastTime,
  });

  final bool wsLive;
  final bool occ;
  final String device;
  final String lastTime;

  @override
  Widget build(BuildContext context) {
    final dotColor = wsLive ? const Color(0xFF2EE59D) : const Color(0xFF777777);
    final occColor = occ ? const Color(0xFF2EE59D) : const Color(0xFF777777);

    Widget pill(Widget child) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
        color: Colors.white.withOpacity(0.06),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 12,
          color: Colors.white.withOpacity(0.75),
          fontWeight: FontWeight.w600,
        ),
        child: child,
      ),
    );

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.end,
      children: [
        pill(Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(wsLive ? 'Live' : 'Offline'),
        ])),
        pill(Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: occColor, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text('Presence: ${occ ? "YES (movement)" : "NO"}'),
        ])),
        pill(Text('Device $device')),
        pill(Text('Last update: $lastTime')),
      ],
    );
  }
}
