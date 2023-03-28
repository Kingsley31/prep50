

import 'package:flutter/cupertino.dart';
import 'package:prep50/services/auth-service.dart';

class PasswordResetScreenViewModel extends ChangeNotifier{
  String _email = '';
  AuthService _authService = AuthService();

  set email(String email) {
    this._email = email;
  }

  String get email{
      return this._email;
  }

  Future<String> sendPasswordResetLink() async {
     String message = await  _authService.sendResetPasswordLink(this._email);
     return message;
  }
}