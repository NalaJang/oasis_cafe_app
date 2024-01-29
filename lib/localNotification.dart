import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // 싱글톤으로 생성
  static final LocalNotification _instance = LocalNotification._();
  factory LocalNotification() {
    return _instance;
  }
  LocalNotification._();

  // local notification 플러그인 객체 생성
  static FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  static init() async {
    // 알림을 표시할 아이콘
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

    // 알림 초기화
    await plugin.initialize(initializationSettings);
  }

  // ios 에서 권한 요청을 하기 위한 함수
  // Future<bool> requestNotificationPermission() async {
  //   if( Platform.isAndroid ) {
  //     result = true;
  //
  //   }
  //   else if( Platform.isIOS || Platform.isMacOS ) {
  //     result = await plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
  //                           ?.requestPermissions(
  //                           alert: true,
  //                           badge: true,
  //                           sound: true
  //     );
  //   }
  //   return result;
  // }

  static const String channelId = 'channel id';
  static const String channelName = 'channel name';

  Future<void> showNotification(String orderStatus) async {
    // 알림 채널 설정 값 구성
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'channel description',
      importance: Importance.high,
    );

    // 알림 상세 정보 설정
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(badgeNumber: 1)
    );

      await plugin.show(0, 'plain title', orderStatus, notificationDetails);
  }
}