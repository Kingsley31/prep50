
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/user_exam.dart';
import 'package:prep50/utils/exceptions.dart';

import '../utils/prep50_api_utils.dart';

class UserExamService{
  String baseUrl = BASE_URL;


  Future<List<UserExam>> getUserExams() async {
    final String accessToken = await getApiToken();
    String userExamBoardEndpoint = "/user/exams";
    final response = await http.get(
      Uri.parse('$baseUrl$userExamBoardEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    
    if(response.statusCode == 200){
      final Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final List<dynamic> userExamsJsonList = jsonResponse["data"];
      List<UserExam> userExamsList = userExamsJsonList.map((userExamJson) => UserExam.fromJson(userExamJson)).toList();
      return userExamsList;
    }
    print(response.statusCode);
    print(response.body);
    throw ValidationException(message: "Error fetching user exams, is your device online?", errors: []);

  }
}