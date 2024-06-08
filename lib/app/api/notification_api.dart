import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initialization() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your_channel_id', 'your_channel_ane',
          importance: Importance.max, priority: Priority.high);

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(1, 
  'ທ່ານໄດ້ຈອງ',
  'ວັນທີເດືອນປີ້ ${DateTime.now().toString()}'
  ,notificationDetails);
}
