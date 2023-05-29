

import 'package:prep50/models/user.dart';

/// This model represents the response returned when user
/// has successfully logged in via prep50 login end point
class LoginResponse{
  User user;
  String accessCode;
  String refreshToken;
  String accessExpiresAt;
  String refreshExpiresAt;

  LoginResponse({required this.user,required this.accessCode,required this.refreshToken,required this.accessExpiresAt,required this.refreshExpiresAt});

  LoginResponse.fromJson(Map<String,dynamic> json):
      user = User.fromJson(json["user"]),
      accessCode=json["access"],
      refreshToken=json["refresh"],
      accessExpiresAt=json["access_expires_at"],
      refreshExpiresAt=json["refresh_expires_at"];

  toJson() => {
    "access":accessCode,
    "refresh":refreshToken,
    "user":user.toJson(),
    "access_expires_at":accessExpiresAt,
    "refresh_expires_at":refreshExpiresAt
  };

}