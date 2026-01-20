import 'package:flutter/material.dart';

import '../features/onboarding/presentation/get_started_screen.dart';
import '../features/onboarding/presentation/get_started_screen2.dart';
import '../features/onboarding/presentation/get_started_screen3.dart';
import '../features/shell/presentation/main_shell.dart';

class AppRoutes {
  static const String getStarted = '/';
  static const String getStarted2 = '/get_started2';
  static const String getStarted3 = '/get_started3';
  static const String shell = '/shell';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      case getStarted2:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen2());
      case getStarted3:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen3());
      case shell:
        return MaterialPageRoute(builder: (_) => const MainShell());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}