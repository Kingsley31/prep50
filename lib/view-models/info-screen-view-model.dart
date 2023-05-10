
import 'package:flutter/foundation.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:prep50/models/subject.dart';
import 'package:prep50/models/user.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/services/exam-board-service.dart';
import 'package:prep50/services/subject-service.dart';
import 'package:prep50/storage/app_data.dart';


class InfoScreenViewModel extends ChangeNotifier{
  final SubjectService _subjectService = SubjectService();
  final ExamBoardService _examBoardService = ExamBoardService();
  final AuthService _authService = AuthService();
  final AppData _appData = AppData();
  final Set<int> _selectedSubjectIds = {};
  ExamBoard? _selectedExamBoard;
  List<ExamBoard> _examBoardList = [];
  String _selectedExamBoardDialogString ="";

  String get selectedExamBoardDialogString{
    return _selectedExamBoardDialogString;
  }

  set setExamBoardList(List<ExamBoard> examBoards){
    _examBoardList = examBoards;
  }

  List<ExamBoard> get getExamBoardList{
    return _examBoardList;
  }

  Future<List<Subject>> getAllSubjects(){
    return _subjectService.getAllSubjectsWithTopic();
  }

  Future<List<ExamBoard>> getAllExamBoards(){
    return _examBoardService.getAllExamBoards();
  }
  set setSelectedExamBoard(ExamBoard examBoard){
    _selectedExamBoard = examBoard;
    notifyListeners();
  }

  set setSelectedExamBoardDialogString(String selectedExamBoardDialogString){
    _selectedExamBoardDialogString = selectedExamBoardDialogString;
    notifyListeners();
  }

  ExamBoard? get getSelectedExamboard{
    return _selectedExamBoard;
  }

  set addSelectedSubject(int subjectId){
    _selectedSubjectIds.add(subjectId);
  }


  set removeSelectedSubject(int subjectId){
    _selectedSubjectIds.remove(subjectId);
  }

  Set<int> get getSelectedSubjectIds{
    return _selectedSubjectIds;
  }

  Future<Map<String,dynamic>> updateUserSubjects() async{
    final String accessToken = await _appData.getToken() ?? "";
    final Map<String,dynamic> updateUserJsonResponse = await _authService.updateUserSubjects(_selectedExamBoard?.name.toLowerCase() ?? "",_selectedSubjectIds, accessToken);
    final userJson = await _appData.getUser();
    User loggedInUser = User.fromJson(userJson!);
    loggedInUser.hasRegisteredExam = true;
    await _appData.saveUser(loggedInUser.toJson());
    await _appData.setRegistrationCompleted(true);
    return updateUserJsonResponse;
  }

}