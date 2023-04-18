import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/podcast_topic.dart';
import 'package:prep50/models/subject.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/topic.dart';

class SubjectService{
  //final String baseUrl = "https://730793d0-3f8d-4d32-ac04-9e01b3e4bff7.mock.pstmn.io";
  final String baseUrl = BASE_URL;
  final String subjectEndpoint = "/resources/subjects";
  final String subjectEndpointWithTopic = "/resources/subjects";

  Future<List<Subject>> getAllSubjectsWithoutTopic() async {
    final response = await http.get(
      Uri.parse('$baseUrl$subjectEndpoint'),
    );
    return loadSubjectResponse(response);
  }

  Future<List<Subject>> getAllSubjectsWithTopic() async {
    final response = await http.get(
      Uri.parse('$baseUrl$subjectEndpointWithTopic'),
    );
    return loadSubjectResponse(response);
  }

  List<Subject> loadSubjectResponse(http.Response response){
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> subjectsJson = jsonResponse['data'];
      print(subjectsJson);
      List<Subject> subjects = subjectsJson.map((subjectJson) => Subject.fromJson(subjectJson)).toList();
      return subjects;
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load subjects, is the device online');
    }
  }

  Future<List<Subject>> getUserExamSubjects(String exam,String accessCode) async {
    final String userExamSubjectsEndpoint = "/study/subjects";
    final response = await http.post(
      Uri.parse('$baseUrl$userExamSubjectsEndpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessCode',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String,dynamic>{
        "exam":[exam],
        "withObjective":false
      })
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      final responseDataJson = jsonResponse["data"];
      final  List<dynamic> subjectListJson = responseDataJson[exam.toUpperCase()];
      final List<Subject> subjectList = subjectListJson.map((subjectJson) => Subject.fromJson(subjectJson)).toList();
      return subjectList;
    }

    throw ValidationException(message: "Error fetching subject, is the device online", errors: []);
  }


  Future<List<Topic>> getSubjectTopicsAndLessons(int subject_id,String accessCode) async {
    final topicsAndLessonsEndpoint = "/study/topics";
    final response = await http.post(
        Uri.parse('$baseUrl$topicsAndLessonsEndpoint'),
      headers: < String, String>{
        'Authorization': 'Bearer $accessCode',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String,dynamic>{
        "subject": [subject_id],
        "objective": [],
        "withObjective": true,
        "withLesson": true,
        "filterEmptyTopic": true,
        "filterEmptyObjective": true
      }),
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> topicsJsonList = jsonResponse["data"];
      print(topicsJsonList);
      final List<Topic> topicsAndLessonsList = topicsJsonList.map((topicJson) => Topic.fromJson(topicJson)).toList();
      return topicsAndLessonsList;
    }

    throw ValidationException(message: "Error fetching topics, is the device online", errors: []);

  }

  Future<List<PodcastTopic>> getSubjectTopicsAndPodcasts(int subject_id,String accessCode) async {
    final topicsAndLessonsEndpoint = "/study/podcast?subject=$subject_id";
    print(subject_id);
    final response = await http.get(
      Uri.parse('$baseUrl$topicsAndLessonsEndpoint'),
      headers: < String, String>{
        'Authorization': 'Bearer $accessCode',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final List<dynamic> topicsJsonList = jsonResponse["data"];
      print(topicsJsonList);
      final List<PodcastTopic> topicsAndPodcastsList = topicsJsonList.map((topicJson) => PodcastTopic.fromJson(topicJson)).toList();
      return topicsAndPodcastsList;
    }

    throw ValidationException(message: "Error fetching topics, is the device online", errors: []);

  }
}