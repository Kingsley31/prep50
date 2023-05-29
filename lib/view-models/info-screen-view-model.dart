
import 'package:flutter/foundation.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/exam_board.dart';
import 'package:prep50/models/subject.dart';
import 'package:prep50/models/user.dart';
import 'package:prep50/services/auth-service.dart';
import 'package:prep50/services/exam-board-service.dart';
import 'package:prep50/services/subject-service.dart';
import 'package:prep50/storage/app_data.dart';

import '../utils/exceptions.dart';


class InfoScreenViewModel extends ChangeNotifier{
  final SubjectService _subjectService = SubjectService();
  final ExamBoardService _examBoardService = ExamBoardService();
  final AuthService _authService = AuthService();
  final AppData _appData = AppData();
  final Set<int> _selectedSubjectIds = {};
  Map<String,List<int>> _subjectUpdatePayload=Map();
  ExamBoard? _selectedExamBoard;
  List<ExamBoard> _examBoardList = [];
  String _selectedExamBoardDialogString ="";
  int _currentExamBoardIndex=0;
  int _totalNumOfExamBoards = 0;
  bool _examBoardIsBoth = false;
  List<Subject> _subjectsList=[];
  bool _isLoadingSubjects=false;
  String _errorMessage = "";

  bool get isLoadingSubjects{
    return _isLoadingSubjects;
  }

  String get errorMessage{
    return _errorMessage;
  }

  List<Subject> get subjectsList{
    return _subjectsList;
  }

  bool get examBoardIsBoth{
    return _examBoardIsBoth;
  }

  int get currentExamBoardIndex{
    return _currentExamBoardIndex;
  }

  int get totalNumOfExamBoards{
    return _totalNumOfExamBoards;
  }

  String get selectedExamBoardDialogString{
    return _selectedExamBoardDialogString;
  }

  set setExamBoardList(List<ExamBoard> examBoards){
    _examBoardList.clear();
    _examBoardList.addAll(examBoards);
    _examBoardList.removeWhere((element) => element.name.toLowerCase()==BOTH_JAMB_AND_WAEC_EXAM_BOARDS);
    _currentExamBoardIndex=0;
    _totalNumOfExamBoards=_examBoardList.length-1;
  }

  List<ExamBoard> get getExamBoardList{
    return _examBoardList;
  }

  loadAllSubjects()async{
    _isLoadingSubjects=true;
    _errorMessage="";
    notifyListeners();
    try{
      _subjectsList.clear();
      _subjectsList= await _subjectService.getAllSubjectsWithTopic();
      _isLoadingSubjects=false;
      notifyListeners();
    }on LoginException catch(e){
      _isLoadingSubjects=false;
      _errorMessage=e.message;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingSubjects=false;
      _errorMessage=e.message;
      notifyListeners();
    }catch(e){
      _isLoadingSubjects=false;
      _errorMessage=e.toString().substring(11);
      notifyListeners();
    }
  }

  Future<List<ExamBoard>> getAllExamBoards(){
    return _examBoardService.getAllExamBoards();
  }

  set setSelectedExamBoard(ExamBoard examBoard){
    if(examBoard.name.toLowerCase()==BOTH_JAMB_AND_WAEC_EXAM_BOARDS){
      _selectedExamBoard = _examBoardList[_currentExamBoardIndex];
      _examBoardIsBoth=true;
      _selectedSubjectIds.clear();
      notifyListeners();
      return;
    }
    _selectedExamBoard = examBoard;
    _examBoardIsBoth=false;
    _selectedSubjectIds.clear();
    _totalNumOfExamBoards=0;
    _currentExamBoardIndex=0;
    notifyListeners();
  }

  next(){
    _subjectUpdatePayload[_selectedExamBoard!.name.toLowerCase()]=_selectedSubjectIds.toList();
    _currentExamBoardIndex+=1;
    _selectedExamBoard=_examBoardList[_currentExamBoardIndex];
    _selectedSubjectIds.clear();
    notifyListeners();
  }

  previous(){
    _currentExamBoardIndex-=1;
    _selectedExamBoard=_examBoardList[_currentExamBoardIndex];
    _selectedSubjectIds.clear();
    notifyListeners();
  }

  set setSelectedExamBoardDialogString(String selectedExamBoardDialogString){
    _selectedExamBoardDialogString = selectedExamBoardDialogString;
    notifyListeners();
  }

  ExamBoard? get getSelectedExamboard{
    return _selectedExamBoard;
  }

  set addSelectedSubjectWithoutNotification(int subjectId){
    _selectedSubjectIds.add(subjectId);
  }
  set addSelectedSubject(int subjectId){
    _selectedSubjectIds.add(subjectId);
    notifyListeners();
  }


  set removeSelectedSubject(int subjectId){
    _selectedSubjectIds.remove(subjectId);
    notifyListeners();
  }

  Set<int> get getSelectedSubjectIds{
    return _selectedSubjectIds;
  }

  Future<Map<String,dynamic>> updateUserSubjects() async{
    _subjectUpdatePayload[_selectedExamBoard!.name.toLowerCase()]=_selectedSubjectIds.toList();
    final Map<String,dynamic> updateUserJsonResponse = await _authService.updateUserSubjects(_subjectUpdatePayload);
    final userJson = await _appData.getUser();
    User loggedInUser = User.fromJson(userJson!);
    loggedInUser.hasRegisteredExam = true;
    await _appData.saveUser(loggedInUser.toJson());
    await _appData.setRegistrationCompleted(true);
    return updateUserJsonResponse;
  }

}