import 'package:flutter/cupertino.dart';
import 'package:prep50/models/login_response.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/storage/app_data.dart';

import '../models/user.dart';
import '../services/notification_service.dart';
import '../utils/pushnotification_utils.dart';

class CreateAccountViewModel extends ChangeNotifier{
  final AuthService _authService = AuthService();
  final AppData _appData = AppData();
  NotificationService _notificationService = NotificationService();
  String _email="";
  String _username="";
  String _phone="";
  String _password="";

  set setEmail(String email){
    _email = email;
  }

  set setUsername(String username){
    _username = username;
  }

  set setPhone(String phone){
    _phone = phone;
  }

  set setPassword(String password){
    _password = password;
  }

  Future<User> registerUser() async {
    final LoginResponse loginResponse = await _authService.registerUser(_username, _email, _phone, _password);
    final User user = loginResponse.user;
    final String accessToken = loginResponse.accessCode;
    final String refreshToken = loginResponse.refreshToken;
    final fcmToken = await getDeviceToken();
    await _notificationService.registerDeviceToken(accessCode: accessToken, token: fcmToken);
    await _appData.saveUser(user.toJson());
    await _appData.saveApiToken(accessToken);
    await _appData.saveApiRefreshToken(refreshToken);
    await _appData.setUserLoginStatus(true,AppData.loginTypePassword);
    await _appData.setRegistrationCompleted(false);
    await _appData.setLoginPassword(_password);
    await _appData.setLoginUsername(_email);
    return user;
  }


}