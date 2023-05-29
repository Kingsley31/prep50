

import 'package:flutter/material.dart';
import 'package:prep50/models/user_exam.dart';
import 'package:prep50/utils/prep50_api_utils.dart';

import '../constants/string_data.dart';
import '../models/subject.dart';
import '../services/subject-service.dart';
import '../services/user-exam-service.dart';
import '../utils/exceptions.dart';

class PrepStudySubjectsViewModel extends ChangeNotifier{
  final UserExamService _userExamService = UserExamService();
  final SubjectService _subjectService = SubjectService();
  List<Subject> _studentSubjects=[];
  List<UserExam> _userExamList = [];
  bool _isLoadingSubjects=false;
  String _errorMessage="";
  bool _userShouldSelectExamBoard=false;
  bool _shouldTakeUserToSubscriptionScreen=false;

  bool get shouldTakeUserToSubscriptionScreen{
    return _shouldTakeUserToSubscriptionScreen;
  }

  bool get userShouldSelectExamBoard{
    return _userShouldSelectExamBoard;
  }

  bool get isLoadingSubjects{
    return _isLoadingSubjects;
  }

  String get errorMessage{
    return _errorMessage;
  }

  List<Subject> get studentSubjects{
    return _studentSubjects;
  }

  List<UserExam> get userExamList{
    return _userExamList;
  }


  loadStudentExamSubjects() async{
    _isLoadingSubjects=true;
    _errorMessage="";
    notifyListeners();
    try{
      _userExamList = await _userExamService.getUserExams();
      if(_userExamList.length>1){
        _userShouldSelectExamBoard=true;
      }
      _shouldTakeUserToSubscriptionScreen=checkShouldTakeUserToSubscriptionScreen(_userExamList);
      final UserExam userExam = _userExamList[0];
      _studentSubjects=await _subjectService.getUserExamSubjects(userExam.exam.toLowerCase());
      _isLoadingSubjects=false;
      notifyListeners();
    }on LoginException catch (e){
      _isLoadingSubjects=false;
      _errorMessage = e.message;
      notifyListeners();
    }on ValidationException catch (e){
      _isLoadingSubjects=false;
      _errorMessage = e.message;
      notifyListeners();
    }catch(e){
      _isLoadingSubjects=false;
      _errorMessage = e.toString().substring(11);
      notifyListeners();
    }
  }

  loadExamSubjects(UserExam userExam) async{
    _isLoadingSubjects=true;
    _errorMessage="";
    _userShouldSelectExamBoard=false;
    notifyListeners();
    try{
      _studentSubjects=await _subjectService.getUserExamSubjects(userExam.exam.toLowerCase());
      _isLoadingSubjects=false;
      notifyListeners();
    }on LoginException catch (e){
      _isLoadingSubjects=false;
      _errorMessage = e.message;
      notifyListeners();
    }on ValidationException catch (e){
      _isLoadingSubjects=false;
      _errorMessage = e.message;
      notifyListeners();
    }catch(e){
      _isLoadingSubjects=false;
      _errorMessage = e.toString().substring(11);
      notifyListeners();
    }
  }
}