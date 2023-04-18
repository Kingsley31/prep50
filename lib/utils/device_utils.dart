

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getCurrentDeviceName() async {
   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
      return androidInfo.model ?? "";

   }else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      return iosInfo.utsname.machine ?? "";
   }
   return "";
}

Future<String> getCurrentDeviceId()async{
   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   if (Platform.isAndroid) {
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      return androidId??"";
   } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor??"";
   }
   return "";
}