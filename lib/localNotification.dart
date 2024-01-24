import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // 싱글톤으로 생성
  // LocalNotification._();

  var result;

  // local notification 플러그인 객체 생성
  static FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  static init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      // 내가 원할 때 권한 요청을 하기 위해 false 값을 부여.
      // true 일 경우, 앱이 실행되고 바로 권한 요청을 한다.
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );

    const InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);

    await plugin.initialize(initializationSettings);
  }

  // ios 에서 권한 요청을 하기 위한 함수
  Future<bool> requestNotificationPermission() async {
    if( Platform.isAndroid ) {
      result = true;

    }
    else if( Platform.isIOS || Platform.isMacOS ) {
      result = await plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
                            ?.requestPermissions(
                            alert: true,
                            badge: true,
                            sound: true
      );
    }
    return result;
  }

  static const String channelId = 'channel id';
  static const String channelName = 'channel name';

  Future<void> showNotification() async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'channel description',
      importance: Importance.defaultImportance,
      priority: Priority.max,
      showWhen: false
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(badgeNumber: 1)
    );

    if( result == true ) {
      await plugin.show(0, 'plain title', 'plain body', notificationDetails);
    }
  }
}