import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C5CFF), Color(0xFF2EE59D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C5CFF).withOpacity(0.35),
                blurRadius: 30,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF0B1020).withOpacity(0.35),
              border: Border.all(color: Colors.white.withOpacity(0.18)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('HeartGuard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              SizedBox(height: 2),
              Text(
                'Live desk stress & environment monitor',
                style: TextStyle(fontSize: 13, color: Color(0xA8E8ECFF)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
