
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getDeviceToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Device Token: ${fcmToken}");
  return fcmToken ?? "";
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}

void listenForForegroundFcmMessages() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

void requestPushNotificationPermissionOnIos() async{
  if(Platform.isAndroid==false){
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
