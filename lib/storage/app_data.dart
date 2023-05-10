

import 'dart:convert';

import 'package:prep50/models/podcast_topic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static const String loginTypePassword = "password";
  static const String loginTypeFacebook = "facebook";
  static const String loginTypeGoogle = "google";


  Future<Map<String,dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String userString = prefs.getString("user") ?? "";
    print(userString);
    return json.decode(userString);
  }

  saveUser(Map<String,dynamic> userJsonObject) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(userJsonObject));
  }

  //when status = true user is logged in and vice versa
  setUserLoginStatus(bool status,String loginType) async {
    final prefs = await SharedPreferences.getInstance();
    if(status==true){
      await prefs.setBool("is_logged_in", status);
      await prefs.setString("login_type", loginType);
    }else{
      await prefs.remove("user");
      await prefs.remove("api_token");
      await prefs.remove("is_logged_in");
      await prefs.remove("login_type");
    }

  }

  Future<bool> getUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_logged_in") ?? false;
  }

  setRegistrationCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("registration_completed", completed);
  }
  Future<bool> getRegistrationCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("registration_completed") ?? false;
  }

  Future<String?> getUserLoginType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_type");
  }

  saveApiToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("api_token", token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("api_token");
  }

  setSmartLock(bool enabled)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("smart_lock", enabled);
  }

  Future<bool> getSmartLockEnabled()async{
    final prefs = await SharedPreferences.getInstance();
    bool? enabled= prefs.getBool("smart_lock");
    return enabled==null?false:enabled!;
  }

  setLoginPassword(String password)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("login_password", password);
  }

  Future<String?> getLoginPassword()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_password");
  }

  saveApiRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("api_refresh_token", refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("api_refresh_token");
  }

  saveUserSubjectFavouriteTopics(int subject_id,List<PodcastTopic> topics) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("$subject_id", jsonEncode(topics.map<Map<String,dynamic>>((topic) => topic.toJson()).toList()));
  }

  Future<List<PodcastTopic>> getUserSubjectFavouriteTopics(int subject_id) async{
    final prefs = await SharedPreferences.getInstance();
    final String? topicsString = prefs.getString("$subject_id");
    if(topicsString ==null){
      return [];
    }
    print(topicsString);
    List<PodcastTopic> topics =  json.decode(topicsString).map<PodcastTopic>((topiJson) => PodcastTopic.fromJson(topiJson)).toList();
    return topics;
  }

 Future<bool> getFingerPrintEnable() async{
   final prefs = await SharedPreferences.getInstance();
   return prefs.getBool("fingerprint_enabled")??false;
 }

  setFingerPrintEnabled(bool enabled) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("fingerprint_enabled", enabled);
  }

  setLoginUsername(String username)async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_username", username);
  }

  Future<String> getLoginUsername()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_username")??"";
  }

}