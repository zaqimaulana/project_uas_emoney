import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _transactionChannel = AndroidNotificationChannel(
  'transactions',
  'Transaksi',
  description: 'Notifikasi untuk setiap transaksi masuk dan keluar.',
  importance: Importance.high,
);

Future<void> initNotificationService() async {
  const initSettings = InitializationSettings(
    android: AndroidInitializationSettings('ic_notification'),
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_transactionChannel);
}

void showLocalNotification(RemoteMessage message) {
  final notification = message.notification;
  if (notification == null) return;

  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        _transactionChannel.id,
        _transactionChannel.name,
        channelDescription: _transactionChannel.description,
        importance: Importance.high,
        priority: Priority.high,
        icon: 'ic_notification',
      ),
    ),
  );
}
