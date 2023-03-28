import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:prep50/models/login_response.dart';
import 'package:prep50/utils/exceptions.dart';
import '../models/user.dart';

class AuthService{
  final String baseUrl = "https://prep50.herokuapp.com";


  Future<LoginResponse> registerUser(String username,String email,String phone,String password) async {
    final String registrationEndpoint = "/auth/register";
    final response = await http.post(
      Uri.parse('$baseUrl$registrationEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email':email,
        'phone':phone,
        'password':password,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      String accessCode = jsonResponse["data"]["access"];
      String refreshToken = jsonResponse["data"]["refresh"];
      User user = User.fromJson(jsonResponse["data"]["user"]);
      LoginResponse loginResponse = LoginResponse(user: user, accessCode: accessCode, refreshToken: refreshToken);
      return loginResponse;

    }else if(response.statusCode == 400){
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      //final String message = jsonResponse["message"];
      final Map<String,dynamic> serverErrors = jsonResponse["error"];
      final List<String> errors = [];
      serverErrors.forEach((key, value) {errors.add(value);});
      // If the server did not return a 200 OK response, then throw an exception.
      throw ValidationException(message: errors[0], errors: errors);
    }else {
      throw Exception("Error in network connection, is the device online?");
    }
  }

  Future<LoginResponse> loginUser({required String username,required String password,String? deviceId,String? deviceName}) async {
    final String loginEndpoint = "/auth/login";
    final response = await http.post(
      Uri.parse('$baseUrl$loginEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username':username,
        'password':password,
        "device_id": deviceId ?? "",
        "device_name":deviceName ?? ""
      }),
    );

    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      String accessCode = jsonResponse["data"]["access"];
      String refreshToken = jsonResponse["data"]["refresh"];
      User user  = User.fromJson(jsonResponse["data"]["user"]);
      LoginResponse loginResponse = LoginResponse(user: user, accessCode: accessCode, refreshToken: refreshToken);
      return loginResponse;
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


  Future<LoginResponse> loginUserWithGoogle({required String username,required String phone,required String email,String? deviceId,String? deviceName}) async {
    final String loginEndpoint = "/auth/provider/google";
    final response = await http.post(
      Uri.parse('$baseUrl$loginEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username':username,
        'email':email,
        'phone':phone,
        "device_id": deviceId ?? "",
        "device_name":deviceName ?? ""
      }),
    );

    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      String accessCode = jsonResponse["access"];
      String refreshToken = jsonResponse["refresh"];
      User user  = User.fromJson(jsonResponse["user"]);
      LoginResponse loginResponse = LoginResponse(user: user, accessCode: accessCode, refreshToken: refreshToken);
      return loginResponse;
    }else if(response.statusCode == 400){
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      final Map<String,dynamic> serverErrors = jsonResponse["error"];
      final List<String> errors = [];
      serverErrors.forEach((key, value) {errors.add("$key: $value");});
      // If the server did not return a 200 OK response, then throw an exception.
      throw ValidationException(message: errors[0], errors: errors);
    }else if(response.statusCode == 403 || response.statusCode == 406){
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

  Future<LoginResponse> loginUserWithFacebook({required String username,required String phone,required String email,String? deviceId,String? deviceName}) async {
    final String loginEndpoint = "/auth/provider/facebook";
    final response = await http.post(
      Uri.parse('$baseUrl$loginEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username':username,
        'email':email,
        'phone':phone,
        "device_id": deviceId ?? "",
        "device_name":deviceName ?? ""
      }),
    );

    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      String accessCode = jsonResponse["access"];
      String refreshToken = jsonResponse["refresh"];
      User user  = User.fromJson(jsonResponse["user"]);
      LoginResponse loginResponse = LoginResponse(user: user, accessCode: accessCode, refreshToken: refreshToken);
      return loginResponse;
    }else if(response.statusCode == 400){
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      final Map<String,dynamic> serverErrors = jsonResponse["error"];
      final List<String> errors = [];
      serverErrors.forEach((key, value) {errors.add("$key: $value");});
      // If the server did not return a 200 OK response, then throw an exception.
      throw ValidationException(message: errors[0], errors: errors);
    }else if(response.statusCode == 403 || response.statusCode == 406){
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


  Future<Map<String,dynamic>> updateUserSubjects(String examBoard,Set<int> selectedSubjects,String accessToken) async {
    final String updateEndpoint = "/user/subjects";
    print(selectedSubjects.toString());
    print(accessToken);
    final response = await http.post(
      Uri.parse('$baseUrl$updateEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        examBoard:selectedSubjects.toList(),
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if(jsonResponse['status']=="success"){
        print(jsonResponse);
        return jsonResponse;
      }else if(jsonResponse['status']=="failed"){
        throw Exception(jsonResponse['error'][0]);
      }else{
        throw Exception('Failed to update user.');
      }
    }else {
      // If the server did not return a 200 OK response, then throw an exception.
      print("The error is here");
      throw Exception('Failed to update user.');
    }
  }


  Future<Map<String,dynamic>> logoutUser(String accessCode) async {
    final String userDetailsEndpoint="/auth/logout";
    final response = await http.get(
      Uri.parse('$baseUrl$userDetailsEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessCode',
        'Content-Type': 'application/json',
      },
    );
    print("Access Code: $accessCode");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']=="success"){
        print(jsonResponse);
        return jsonResponse;
      }else if(jsonResponse['status']=="failed"){
        throw Exception(jsonResponse['error'][0]);
      }else{
        throw Exception('Failed to logout user.');
      }
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to logout user.');
    }
  }


  Future<Map<String,dynamic>> getUserDetails(String accessToken) async {
    final String userDetailsEndpoint="/user";
    final response = await http.get(
      Uri.parse('$baseUrl$userDetailsEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']=="success"){
        print(jsonResponse);
        return jsonResponse;
      }else if(jsonResponse['status']=="failed"){
        throw Exception(jsonResponse['error'][0]);
      }else{
          throw Exception('Failed to load user details.');
      }
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load user details.');
    }
  }

  Future<String> sendResetPasswordLink(String email) async {
    String passwordResetEndpoint = '/password-reset?user=$email';
    final response = await http.post(
      Uri.parse('$baseUrl$passwordResetEndpoint'),
    );
     print(response.statusCode);
     print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      return message;
    }else if ( response.statusCode == 404 || response.statusCode == 403){
      final jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      throw ValidationException(message: message, errors: []);
    }else{
      throw Exception('Error in network connection, is the device online?');
    }
  }

}