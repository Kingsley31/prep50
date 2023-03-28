
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getDeviceToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Device Token: ${fcmToken}");
  return fcmToken ?? "";
}