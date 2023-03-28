

import 'package:prep50/models/user.dart';

/// This model represents the response returned when user
/// has successfully logged in via prep50 login end point
class LoginResponse{
  User user;
  String accessCode;
  String refreshToken;

  LoginResponse({required this.user,required this.accessCode,required this.refreshToken});

}