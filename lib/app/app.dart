import 'package:flutter/material.dart';
import 'routes.dart';
import '../core/ui/app_colors.dart';

class HeartGuardApp extends StatelessWidget {
  const HeartGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeartGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.brand,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: AppRoutes.getStarted,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
