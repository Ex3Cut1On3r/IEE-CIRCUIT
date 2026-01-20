import 'package:flutter/material.dart';

import '../features/onboarding/presentation/get_started_screen.dart';
import '../features/shell/presentation/main_shell.dart';

class AppRoutes {
  static const String getStarted = '/';
  static const String shell = '/shell';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
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
