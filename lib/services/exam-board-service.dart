import 'dart:convert';

import 'package:prep50/models/exam_board.dart';
import 'package:http/http.dart' as http;

import '../constants/string_data.dart';

class ExamBoardService{
  final String baseUrl = BASE_URL;
  final String examBoardEndpoint = "/resources/exams";

  Future<List<ExamBoard>> getAllExamBoards() async {
    final response = await http.get(
      Uri.parse('$baseUrl$examBoardEndpoint'),
    );
    return loadExamBoardResponse(response);
  }



  List<ExamBoard> loadExamBoardResponse(http.Response response){
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> examBoardsJson = jsonResponse['data'];
      List<ExamBoard> examBoards = examBoardsJson.map((examBoardJson) => ExamBoard.fromJson(examBoardJson)).toList();
      return examBoards;
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Exam Boards is the device online');
    }
  }


}