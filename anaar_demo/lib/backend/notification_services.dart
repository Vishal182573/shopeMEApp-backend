import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap-hdpi/ic_launcher.png');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // id
      'Your Channel Name', // name
      description: 'Your channel description', // description
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Show notification method
  static Future<void> showNotification({
    var  id=0,
    required String title,
    required String body,
    var payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // must match the channel id above
      'Your Channel Name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    
    );
  }
}
