
import 'package:flutter/widgets.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:prep50/models/user_exam.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/services/exam-board-service.dart';
import 'package:prep50/services/subject-service.dart';
import 'package:prep50/services/user-exam-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/subject.dart';

class SubjectReselectionScreenViewModel extends ChangeNotifier{
  final AppData _appData = AppData();
  final ExamBoardService _examBoardService = ExamBoardService();
  final UserExamService _userExamService = UserExamService();
  final SubjectService _subjectService = SubjectService();
  final AuthService _authService = AuthService();
  ExamBoard _selectedExamBoard = ExamBoard(name: "", price: 0, subject_count: 0, status: false);
  List<Subject> _allSubjects = [];
  List<Subject> _userSubjects = [];
  Set<int> _removedSubjectIds={};
  Set<int> _addedSubjectIds = {};
  bool _isLoadingSubjects=false;
  String _errorMessage="";

  bool get isLoadingSubjects{
    return _isLoadingSubjects;
  }

  String get errorMessage{
    return _errorMessage;
  }

  ExamBoard get selectedExamBoard{
    return _selectedExamBoard;
  }

  List<Subject> get allSubjects{
    return _allSubjects;
  }

  List<Subject> get userSubjects{
    return _userSubjects;
  }

  bool subjectIsUserSubject(Subject subject){
    return _userSubjects.any((element) => element.id ==subject.id);
  }

  addSubject(int subjectId){
    _addedSubjectIds.add(subjectId);
    _removedSubjectIds.remove(subjectId);
    _userSubjects.add(_allSubjects.firstWhere((element) => element.id==subjectId));
    notifyListeners();
  }

  removeSubject(int subjectId){
    _removedSubjectIds.add(subjectId);
    _addedSubjectIds.remove(subjectId);
    _userSubjects.removeWhere((element) => element.id==subjectId);
    notifyListeners();
  }

  loadSubject()async{
    _isLoadingSubjects=true;
    _errorMessage="";
    notifyListeners();
    String accessCode = await _appData.getToken()??"";
    try{
      final UserExam userExam = (await _userExamService.getUserExams(accessCode))[0];
      _userSubjects=await _subjectService.getUserExamSubjects(userExam.exam.toLowerCase(), accessCode);
      _allSubjects= await _subjectService.getAllSubjectsWithTopic();
      List<ExamBoard> _allExamBoards = await _examBoardService.getAllExamBoards();
      _selectedExamBoard=_allExamBoards.firstWhere((element) => element.name.toLowerCase()==userExam.exam.toLowerCase());
      _isLoadingSubjects=false;
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

  updateUserSubjects()async{
    String accessCode = await _appData.getToken()??"";
    if(_removedSubjectIds.isNotEmpty){
      await _authService.updateUserSelectedSubjects(_selectedExamBoard.name.toLowerCase(), "remove", _removedSubjectIds, accessCode);
    }
    if(_addedSubjectIds.isNotEmpty){
      await _authService.updateUserSelectedSubjects(_selectedExamBoard.name.toLowerCase(), "add", _addedSubjectIds, accessCode);
    }


  }

}