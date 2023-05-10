

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prep50/services/notification_service.dart';

import '../services/auth-service.dart';
import '../storage/app_data.dart';
import '../models/user.dart' as appModel;

class HomeScreenViewModel extends ChangeNotifier{
  final AuthService _authService = AuthService();
  final NotificationService _notificationService = NotificationService();
  final AppData _appData = AppData();

  Future<bool> get userIsLoggedIn async{
    return await _appData.getUserLoginStatus();
  }

  Future<appModel.User> getLoggedInUser() async {
    final userJson = await _appData.getUser();
    final user = appModel.User.fromJson(userJson!);
    print(user);
    return user;
  }

  logoutUser({bool disableSettings=false}) async {
    String? userLoginType = await _appData.getUserLoginType();
    String accessCode = await _appData.getToken() ?? "";
    try{
      await _authService.logoutUser(accessCode);
    }catch(e){}
    await _appData.setUserLoginStatus(false, AppData.loginTypePassword);
    if(disableSettings){
      await _appData.setFingerPrintEnabled(false);
      await _appData.setSmartLock(false);
    }
    if(userLoginType != AppData.loginTypePassword){
      await FirebaseAuth.instance.signOut();
    }
    notifyListeners();
  }

  registerFcmToken(String fcmToken) async{
    String accessCode = await _appData.getToken() ?? "";
    _notificationService.registerDeviceToken(accessCode: accessCode, token: fcmToken);
  }
}