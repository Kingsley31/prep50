import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prep50/models/login_response.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/prep50_api_utils.dart';
import '../constants/string_data.dart';
import '../models/user.dart';
import 'package:http_parser/http_parser.dart';

class AuthService{
  final String baseUrl = BASE_URL;


  Future<LoginResponse> registerUser(String username,String email,String phone,String password,String referer) async {
    final String registrationEndpoint = "/auth/register";
    final registrationDetails = <String, String>{
      'username': username,
      'email':email,
      'phone':phone,
      'password':password,
    };
    if(referer.isNotEmpty){
      registrationDetails.addAll({'referer':referer});
    }
    
    final response = await http.post(
      Uri.parse('$baseUrl$registrationEndpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registrationDetails),
    );
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse["data"]);
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
      print(jsonResponse["data"]["user"]);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse["data"]);
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
      LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse["data"]);
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
      LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse["data"]);
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


  Future<Map<String,dynamic>> updateUserSubjects(Map<String,List<int>> subjectUpdatePayload) async {
    final String updateEndpoint = "/user/subjects";
    final String accessToken = await getApiToken();
    print(subjectUpdatePayload.toString());
    print(accessToken);
    final response = await http.post(
      Uri.parse('$baseUrl$updateEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(subjectUpdatePayload),
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


  Future<Map<String,dynamic>> logoutUser() async {
    final String accessToken = await getApiToken();
    final String userDetailsEndpoint="/auth/logout";
    final response = await http.get(
      Uri.parse('$baseUrl$userDetailsEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    print("Access Code: $accessToken");
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


  Future<User> getUserDetails() async {
    final String accessToken = await getApiToken();
    final String userDetailsEndpoint="/user/profile";
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
      final userJson = jsonResponse['data'];
      User user = User.fromJson(userJson);
      return user;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw ValidationException(message: 'Failed to load user details.',errors: []);
    }
  }

  Future<LoginResponse> updateUserProfile({
    required String phone,
    required String address,
    required String gender,
    required String photo})async{
    final String accessToken = await getApiToken();
      final String userProfileUpdateEndpoint="/user/profile";
      final response = await http.put(
        Uri.parse('$baseUrl$userProfileUpdateEndpoint'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "phone":phone,
          "address":address,
          "gender":gender,
          'photo':photo
        })
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response, then parse the JSON.
        final jsonResponse = jsonDecode(response.body);
        if(jsonResponse['status'] == "success"){
          print(jsonResponse["data"]);
          LoginResponse loginResponse = LoginResponse.fromJson(jsonResponse["data"]);
          return loginResponse;
        }
        throw ValidationException(message: jsonResponse['message'],errors: []);
      } else {
        // If the server did not return a 200 OK response, then throw an exception.
        throw ValidationException(message: 'Failed to load user details, is the device online?',errors: []);
      }
  }

  Future<Map<String,dynamic>> uploadUserProfilePicture({
    required File imageFile
  })async{
    final String accessToken = await getApiToken();
    String photoUploadEndpoint = "/user/profile";
    http.MultipartRequest request = http.MultipartRequest("POST",Uri.parse('$baseUrl$photoUploadEndpoint'));
    request.headers.addAll(<String, String>{
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    });
    print(imageFile.path.split('/').last);
    request.files.add(await http.MultipartFile.fromPath("photo", imageFile.path,contentType: MediaType('image', '${imageFile.path.split('.').last.toLowerCase()}')));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      if(jsonResponse['status'] == "success"){
        return jsonResponse;
      }
      print(jsonResponse['message']);
      throw ValidationException(message: jsonResponse['message'],errors: []);
    }else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw ValidationException(message: 'Failed to upload user photo, is the device online?',errors: []);
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

  Future<Map<String,dynamic>> updateUserSelectedSubjects(String examBoard,String action,Set<int> selectedSubjects) async {
    final String accessToken = await getApiToken();
    final String updateEndpoint = "/user/subjects";
    print(selectedSubjects.toString());
    print(accessToken);
    final response = await http.put(
      Uri.parse('$baseUrl$updateEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        examBoard:{
          "action":action,
          "id":selectedSubjects.toList()
        },
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
        throw ValidationException(message:jsonResponse['message'],errors:[]);
      }else{
        throw ValidationException(message:'Failed to update user.',errors:[]);
      }
    }else {
      // If the server did not return a 200 OK response, then throw an exception.
      //print("The error is here");
      throw ValidationException(message:'Failed to update user.',errors:[]);
    }
  }

  Future<Map<String,dynamic>> changeUserPassword(String oldPassword, String newPassword) async{
    final String accessToken = await getApiToken();
    String changePasswordEndpoint = "/user/change-password";
    final response = await http.post(
      Uri.parse('$baseUrl$changePasswordEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "old_password":oldPassword,
        "password":newPassword
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return jsonResponse;
    }else if(response.statusCode==400){
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']=="failed" && jsonResponse.containsKey("error")){
        throw ValidationException(message:jsonResponse['error']["password"],errors:[]);
      }else{
        throw ValidationException(message:jsonResponse['message'],errors:[]);
      }
    }else {
      // If the server did not return a 200 OK response, then throw an exception.
      //print("The error is here");
      throw ValidationException(message:'Failed to update password, is the device online?.',errors:[]);
    }

  }

}