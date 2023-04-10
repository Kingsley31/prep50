
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:prep50/models/login_response.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prep50/utils/device_utils.dart';
import 'package:prep50/utils/pushnotification_utils.dart';

class LoginScreenViewModel extends ChangeNotifier{
  AuthService _authService = AuthService();
  AppData _appData = AppData();
  String _username = "";
  String _password = "";


  Future<bool> get userIsLoggedIn async{
    return await _appData.getUserLoginStatus();
  }

  Future<String?> get userLoginType async {
    return await _appData.getUserLoginType();
  }

  set setUsername(String username){
    _username = username;
  }

  set setPassword(String password){
    _password = password;
  }

  Future<LoginResponse> loginUser() async {
    String deviceId = await getDeviceToken();
    String deviceName = await getCurrentDeviceName();
    LoginResponse loginResponse = await _authService.loginUser(username:_username,password: _password,deviceId: deviceId,deviceName: deviceName);
    final user = loginResponse.user;
    final String accessToken = loginResponse.accessCode;
    final String refreshToken = loginResponse.refreshToken;
    await _appData.saveUser(user.toJson());
    await _appData.saveApiToken(accessToken);
    await _appData.saveApiRefreshToken(refreshToken);
    await _appData.setUserLoginStatus(true,AppData.loginTypePassword);
    //await _appData.setRegistrationCompleted(false);
    return loginResponse;
  }

  Future<UserCredential> signInWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential.user!=null){
      // final String username = userCredential.user?.displayName ?? "";
      // print("Username: ${username.replaceAll(" ","")}");
      // final String phoneNumber = userCredential.user?.phoneNumber ?? "123456789";
      // print("Phone: ${userCredential.user?.phoneNumber}");
      // final String email = userCredential.user?.email ?? "";
      // print("Email: $email");
      return userCredential;
    }else{
      throw Exception('Failed to login user.');
    }

    //return userCredential;
  }

  Future<UserCredential> signInWithFacebook() async {
    await FirebaseAuth.instance.signOut();
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    String token = loginResult.accessToken != null ? loginResult.accessToken!.token : "";
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(token);
    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    if(userCredential.user!=null){
      // final username = userCredential.user?.displayName ?? "";
      // final phoneNumber = userCredential.user?.phoneNumber ?? "123456789";
      // final email = userCredential.user?.email ?? "";
      return userCredential;
    }else{
      throw Exception('Failed to login user.');
    }
  }

  Future<LoginResponse> authenticateApiWithFacebookDetails(String username,String phoneNumber, String email) async {
    String deviceId = await getDeviceToken();
    String deviceName = await getCurrentDeviceName();
    LoginResponse loginResponse = await _authService.loginUserWithFacebook(username:username.replaceAll(" ",""),phone: phoneNumber,email: email,deviceId: deviceId,deviceName: deviceName);
    final user = loginResponse.user;
    final String accessToken = loginResponse.accessCode;
    final String refreshToken = loginResponse.refreshToken;
    await _appData.saveUser(user.toJson());
    await _appData.saveApiToken(accessToken);
    await _appData.saveApiRefreshToken(refreshToken);
    await _appData.setUserLoginStatus(true,AppData.loginTypeFacebook);
    //await _appData.setRegistrationCompleted(false);
    return loginResponse;
  }

  Future<LoginResponse> authenticateApiWithGoogleDetails(String username,String phoneNumber, String email) async {
    String deviceId = await getDeviceToken();
    String deviceName = await getCurrentDeviceName();
    LoginResponse loginResponse = await _authService.loginUserWithGoogle(username:username.replaceAll(" ",""),phone: phoneNumber,email: email,deviceId: deviceId,deviceName: deviceName);
    final user = loginResponse.user;
    final String accessToken = loginResponse.accessCode;
    final String refreshToken = loginResponse.refreshToken;
    await _appData.saveUser(user.toJson());
    await _appData.saveApiToken(accessToken);
    await _appData.saveApiRefreshToken(refreshToken);
    await _appData.setUserLoginStatus(true,AppData.loginTypeGoogle);
    //await _appData.setRegistrationCompleted(false);
    return loginResponse;
  }

}