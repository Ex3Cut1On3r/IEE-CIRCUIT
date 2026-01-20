import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static const String _channelId = 'heartguard_alerts';
  static const String _channelName = 'HeartGuard Alerts';
  static const String _channelDesc = 'Health and sitting-time notifications';

  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

    // Android notification channel (required for Android 8+)
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
    );

    final androidPlatform =
    _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlatform != null) {
      await androidPlatform.createNotificationChannel(androidChannel);

      // Android 13+ runtime permission request
      await androidPlatform.requestNotificationsPermission();
    }
  }

  static Future<void> showSittingTooLong({required int sitSec}) async {
    final minutes = (sitSec / 60.0);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      1001, // notification id (fixed)
      'HeartGuard: Time to move',
      'You’ve been sitting for ${minutes.toStringAsFixed(1)} min. Stand up for 30–60s.',
      details,
    );
  }
}
