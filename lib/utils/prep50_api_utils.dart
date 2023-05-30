
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/storage/app_data.dart';

import '../models/refresh_token_response.dart';
import '../models/user_exam.dart';
import 'exceptions.dart';

Future<String> getApiToken()async{
  AppData appData = AppData();
  String accessToken = await appData.getToken()??"";
  String refreshToken = await appData.getRefreshToken()??"";
  String accessTokenExpiryDate = await appData.getApiTokenExpiryDate();
  String refreshTokenExpiryDate = await appData.getApiRefreshTokenExpiryDate();
  DateTime accessTokenExpiryDateTime = DateTime.parse(accessTokenExpiryDate);
  DateTime refreshTokenExpiryDateTime = DateTime.parse(refreshTokenExpiryDate);
  DateTime currentDate = DateTime.now();

  if(currentDate.isBefore(accessTokenExpiryDateTime.toLocal())){
    return accessToken;
  }

  if(currentDate.isBefore(refreshTokenExpiryDateTime.toLocal())){
    throw LoginException(message:"Please re-login to access all your dashboard contents");
  }

  RefreshTokenResponse refreshTokenResponse = await _refreshAccessTokenFromServer(refreshToken);
  final String newAccessToken = refreshTokenResponse.accessCode;
  final String newRefreshToken = refreshTokenResponse.refreshToken;
  final String newAccessTokenExpiryDate=refreshTokenResponse.accessExpiresAt;
  final String newRefreshTokenExpiryDate = refreshTokenResponse.refreshExpiresAt;
  await appData.saveApiToken(newAccessToken);
  await appData.saveApiRefreshToken(newRefreshToken);
  await appData.saveApiTokenExpiryDate(newAccessTokenExpiryDate);
  await appData.saveApiRefreshTokenExpiryDate(newRefreshTokenExpiryDate);
  return newAccessToken;
}

Future<RefreshTokenResponse> _refreshAccessTokenFromServer(String refreshToken) async{
  String refreshTokenEndpoint = "/auth/refresh-token";
  final response = await http.post(
    Uri.parse('$BASE_URL$refreshTokenEndpoint'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
    RefreshTokenResponse refreshTokenResponse = RefreshTokenResponse.fromJson(jsonResponse["data"]);
    return refreshTokenResponse;
  }else if(response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 403){
    final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
    String message = jsonResponse["message"];
    throw ValidationException(message:message,errors: []);
  }
  else {
    print(response.statusCode);
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Error in network connection, is the device online?');
  }

}

bool checkShouldTakeUserToSubscriptionScreen(List<UserExam> userExamList){
  return userExamList.any((exam) {
    print("Exam Payment Status: ${exam.paymentStatus}");
    print("Payment Expiry Date: ${exam.expiryDate}");
    if(exam.paymentStatus==PAYMENT_STATUS_PENDING){
      DateTime examRegistrationDate = DateTime.parse(exam.createdAt).toLocal();
      DateTime currentDate = DateTime.now();
      Duration registrationDateDifference = currentDate.difference(examRegistrationDate);
      print("DATE difference in hours: ${registrationDateDifference.inHours}");
      if(registrationDateDifference.inHours>=24){
        return true;
      }
      return false;
    }else if(exam.paymentStatus==PAYMENT_STATUS_COMPLETED){
      DateTime currentSubscriptionDate = DateTime.parse(exam.expiryDate).toLocal();
      DateTime currentDate = DateTime.now();
      if(currentSubscriptionDate.isAfter(currentDate)){
        return true;
      }
      return false;
    }
    return false;
  });
}