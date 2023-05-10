
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:prep50/storage/app_data.dart';

class SecurityAndPrivacyScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  String? _passwordError;
  final LocalAuthentication _auth = LocalAuthentication();

  String? get passwordError{
    return _passwordError;
  }

  set passwordError(String? error){
    _passwordError=error;
  }

  Future<bool> deviceHasBiometrics()async{
    return await _auth.canCheckBiometrics;
  }

  Future<bool> getFingerPrintEnabled()async{
    return await _appData.getFingerPrintEnable();
  }

  Future<bool> authenticateWithFingerPrint(bool enabled)async{
    try {
      final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to ${enabled?"enabled":"disabled"} fingerprint authentication',
          options: AuthenticationOptions(biometricOnly: true)
      );
      return didAuthenticate;
    } on PlatformException {
      return false;
    }
  }

  setFingerPrintEnable(bool enabled)async{
    await _appData.setFingerPrintEnabled(enabled);
    notifyListeners();
  }

  Future<bool> passwordIsCorrect(String password)async{
    bool passwordIsCorrect = password == await _appData.getLoginPassword();
    if(passwordIsCorrect!=true){
      _passwordError="The password you entered was wrong";
      notifyListeners();
      return passwordIsCorrect;
    }
    return passwordIsCorrect;
  }

  Future<bool> getSmartLockEnable()async{
    return await _appData.getSmartLockEnabled();
  }
  setSmartLock(bool enabled)async{
    await _appData.setSmartLock(enabled);
    notifyListeners();
  }
}