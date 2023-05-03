import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prep50/models/login_response.dart';
import 'package:prep50/models/user.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/storage/app_data.dart';


class EditProfileScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  AuthService _authService = AuthService();
  User _user = User(email: "",username: "",phone: "",referral: "",gender: "",exams: [],hasRegisteredExam: false);
  bool _isLoadingUser = false;
  File? _imageFile;
  String _gender = "";

  String get gender{
    return _gender;
  }

  set gender(String gender){
    _gender=gender;
    notifyListeners();
  }

  User get user{
    return _user;
  }

  bool get isLoadingUser{
    return _isLoadingUser;
  }

  File? get imageFile{
    return _imageFile;
  }

  loadUser()async{
    _imageFile=null;
    _isLoadingUser=true;
    notifyListeners();
    final userJson = await _appData.getUser();
    _user = User.fromJson(userJson!);
    _gender=_user.gender;
    _isLoadingUser=false;
    notifyListeners();
  }

  setImageFile(File file){
    _imageFile=file;
    notifyListeners();
  }

  Future<LoginResponse> updateUserProfile({required String phone,required String gender,required String address})async{
    String photo="";
    String accessCode= await _appData.getToken()??"";
     if(_imageFile!=null){
       final uploadResponseJson= await _authService.uploadUserProfilePicture(accessCode: accessCode, imageFile: _imageFile!);
       photo=uploadResponseJson["photo"];
     }
    LoginResponse loginResponse = await _authService.updateUserProfile(accessCode: accessCode, phone: phone, address: address, gender: gender,photo:photo);
    _user = loginResponse.user;
    final String accessToken = loginResponse.accessCode;
    final String refreshToken = loginResponse.refreshToken;
    await _appData.saveUser(_user.toJson());
    await _appData.saveApiToken(accessToken);
    await _appData.saveApiRefreshToken(refreshToken);
    notifyListeners();
    return loginResponse;
  }

}