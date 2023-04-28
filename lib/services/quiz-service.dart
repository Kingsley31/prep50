
import 'dart:convert';

import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:prep50/models/weekly_quiz.dart';
import 'package:prep50/models/weekly_quiz_participant.dart';

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

    throw ValidationException(message: "Error submitting quiz score, is the device online", errors: []);
  }

  Future<WeeklyQuiz> getWeeklyQuiz({required accessCode})async{
    String weeklyQuizEndpoint = "/weekly-quiz";
    final response = await http.get(
        Uri.parse("$_baseUrl$weeklyQuizEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        },
    );

    if(response.statusCode != 200){
      print(response.statusCode);
      throw ValidationException(message: "Error fetching weekly quiz, is the device online", errors: []);
    }

    final jsonResponse = jsonDecode(response.body);
    if(jsonResponse["status"]=="success"){
      //print(jsonResponse["data"]);
      WeeklyQuiz weeklyQuiz = WeeklyQuiz.fromJson(jsonResponse["data"]);
      return weeklyQuiz;
    }
    throw WeeklyQuizException(message:jsonResponse["message"]);
  }

  Future<int> submitUserWeeklyQuizAnswers({required Map<String, String> userAnswers, required String accessCode}) async{
    String quizEndpoint = "/weekly-quiz";
    final response = await http.post(
        Uri.parse("$_baseUrl$quizEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        },
        body:jsonEncode(userAnswers)
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse["data"]["score"];
    }

    throw ValidationException(message: "Error submitting quiz score, is the device online", errors: []);
  }

  Future<List<WeeklyQuizParticipant>> getLeaderBoard({required String accessCode})async{
    String quizEndpoint = "/weekly-quiz/result";
    final response = await http.get(
        Uri.parse("$_baseUrl$quizEndpoint"),
        headers: < String, String>{
          'Authorization': 'Bearer $accessCode',
          'Content-Type': 'application/json',
        },
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      List participantsJsonList = jsonResponse["data"];
      List<WeeklyQuizParticipant> leaderBoard = participantsJsonList.map<WeeklyQuizParticipant>((weeklyQuizParticipantJson) => WeeklyQuizParticipant.fromJson(weeklyQuizParticipantJson)).toList();
      return leaderBoard;
    }

    throw ValidationException(message: "Error submitting quiz score, is the device online", errors: []);
  }

}