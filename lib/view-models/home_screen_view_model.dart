

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
    try{
      await _authService.logoutUser();
    }catch(e){}

    if(disableSettings){
      await _appData.setFingerPrintEnabled(false);
      await _appData.setSmartLock(false);
    }
    await _appData.setUserLoginStatus(false, AppData.loginTypePassword);
    if(userLoginType != AppData.loginTypePassword){
      await FirebaseAuth.instance.signOut();
    }
    notifyListeners();
  }

  registerFcmToken(String fcmToken) async{
    _notificationService.registerDeviceToken(token: fcmToken);
  }
}