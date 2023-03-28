import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:prep50/models/subject.dart';

class SubjectService{
  //final String baseUrl = "https://730793d0-3f8d-4d32-ac04-9e01b3e4bff7.mock.pstmn.io";
  final String baseUrl = "https://prep50.herokuapp.com";
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
      List<Subject> subjects = subjectsJson.map((subjectJson) => Subject.fromJson(subjectJson)).toList();
      return subjects;
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load subjects, is the device online');
    }
  }
}