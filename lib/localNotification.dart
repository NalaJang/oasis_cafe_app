import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  static init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );

    const InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);

    await plugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true
    );
  }

  static const String channelId = 'channel id';
  static const String channelName = 'channel name';

  // static Future<void> showNotification() async {
  //   var androidNotificationDetails = AndroidNotificationDetails(
  //       channelId, channelName,
  //     channelDescription: Importance.max,
  //     showWhen: false
  //   )
  // }
}