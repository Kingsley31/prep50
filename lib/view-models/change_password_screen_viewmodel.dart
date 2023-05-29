
import 'package:flutter/material.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/storage/app_data.dart';

class ChangePasswordScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  AuthService _authService = AuthService();

  Future<Map<String,dynamic>> changePassword(String oldPassword, String newPassword)async{
   final response = await _authService.changeUserPassword(oldPassword,newPassword);
   _appData.setLoginPassword(newPassword);
   return response;
  }

}