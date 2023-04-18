
import 'dart:convert';

import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/question.dart';
import 'package:http/http.dart' as http;

import '../utils/exceptions.dart';

class QuizService{
  String _baseUrl = BASE_URL;

  Future<List<Question>> getObjectiveQuickQuiz({required String accessCode,required int objectiveId})async{
    String quizEndpoint = "/study/quiz?id=$objectiveId";
    final response = await http.get(
      Uri.parse("$_baseUrl$quizEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        }
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> questionJsonList = jsonResponse["data"];
      print(questionJsonList);
      final List<Question> questionList = questionJsonList.map((questionJson) => Question.fromJson(questionJson)).toList();
      return questionList;
    }

    throw ValidationException(message: "Error fetching question, is the device online", errors: []);
  }

  Future<Map<String,dynamic>> submitObjectiveQuizScore({required int percentageScore,required objectiveId, required accessCode})async{
    String quizEndpoint = "/study/quiz";
    final response = await http.post(
        Uri.parse("$_baseUrl$quizEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        },
        body:jsonEncode(<String,dynamic>{
          "id":objectiveId,
          "score":percentageScore
        })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }

    throw ValidationException(message: "Error fetching question, is the device online", errors: []);
  }

}