

import 'package:flutter/material.dart';
import 'package:prep50/models/user_exam.dart';

import '../models/subject.dart';
import '../services/subject-service.dart';
import '../services/user-exam-service.dart';
import '../storage/app_data.dart';

class PrepStudySubjectsViewModel extends ChangeNotifier{
  final AppData _appData = AppData();
  final UserExamService _userExamService = UserExamService();
  final SubjectService _subjectService = SubjectService();


  Future<List<Subject>> getStudentExamSubjects() async{
    String accessCode = await _appData.getToken() ?? "";
    print("Here");
    List<UserExam> userExams = await _userExamService.getUserExams(accessCode);
    UserExam currentUserExam =  userExams[0];
    List<Subject> studentSubjects = await _subjectService.getUserExamSubjects(currentUserExam.exam.toLowerCase(), accessCode);
    return studentSubjects;
  }
}