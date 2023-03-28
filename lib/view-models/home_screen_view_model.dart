

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth-service.dart';
import '../storage/app_data.dart';

class HomeScreenViewModel extends ChangeNotifier{
  final AuthService _authService = AuthService();
  final AppData _appData = AppData();

  Future<bool> get userIsLoggedIn async{
    return await _appData.getUserLoginStatus();
  }

  logoutUser() async {
    String? userLoginType = await _appData.getUserLoginType();
    String accessCode = await _appData.getToken() ?? "";
    try{
      await _authService.logoutUser(accessCode);
    }catch(e){}
    await _appData.setUserLoginStatus(false, AppData.loginTypePassword);
    if(userLoginType != AppData.loginTypePassword){
      await FirebaseAuth.instance.signOut();
    }
    notifyListeners();
  }
}