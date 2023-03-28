

import 'dart:io';

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