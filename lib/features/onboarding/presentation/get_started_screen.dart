import 'package:flutter/material.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../../../core/ui/hg_background.dart';
import '../../../app/routes.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HgBackground(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.s20),

            // big typography wall
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.08,
                      child: Text(
                        "Calm\nFocus\nPosture\nHydration\nBreaks\nDiscipline\nEnergy\nBreathing\nClarity",
                        style: TextStyle(
                          fontSize: 46,
                          height: 0.95,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                        children: [
                          TextSpan(text: "Heart"),
                          TextSpan(
                            text: "Guard",
                            style: TextStyle(color: AppColors.brand),
                          ),
                          TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s16),

            const Text(
              "Desk-based stress monitoring.\nLive CLI, sitting streaks, noise, and environment — with smart nudges.",
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: AppSpacing.s20),

            // pill button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.shell);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s12),
          ],
        ),
      ),
    );
  }
}
