import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/app_spacing.dart';
import '../../../../core/ui/hg_background.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/timeline_list.dart';

class TimelineScreen extends ConsumerWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(dashboardControllerProvider);
    return Scaffold(
      body: HgBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.s20),
            children: [
              Text('Timeline', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Events from the device + server inference.',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 14),
              TimelineList(events: s.events),
            ],
          ),
        ),
      ),
    );
  }
}
