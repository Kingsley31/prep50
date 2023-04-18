
import 'package:flutter/material.dart';
import 'package:prep50/models/question.dart';
import 'package:prep50/services/quiz-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

class QuizQuestionScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  QuizService _quizService = QuizService();
  List<Question> _questions=[];
  late Question _currentQuestion;
  bool _isLoadingQuestions = true;
  String _errorMessage = "";
  bool _completedQuiz = false;
  int _currentQuestionIndex = 0;
  int _lastQuestionIndex = 0;
  int _objectiveId = 0;
  int _totalCorrectAnswers = 0;
  int _numberOfAttemptedQuestions=0;
  int _percentageScore = 0;

  List<Question> get questions {
    return _questions;
  }

  int get totalCorrectAnswers{
    return _totalCorrectAnswers;
  }
  bool get startScoreCalculation{
    return _numberOfAttemptedQuestions == _questions.length;
  }

  int get percentageScore{
    return _percentageScore;
  }

  int get numberOfAttemptedQuestions{
    return _numberOfAttemptedQuestions;
  }

  int get currentQuestionIndex{
    return _currentQuestionIndex;
  }

  int get lastQuestionIndex{
    return _lastQuestionIndex;
  }

  bool get isLoadingQuestions {
    return _isLoadingQuestions;
  }

  bool get completedQuiz {
    return _completedQuiz;
  }

  String get errorMessage{
    return _errorMessage;
  }

  Question get currentQuestion{
    return _currentQuestion;
  }

  void loadQuestions(int objectiveId) async {
    _isLoadingQuestions=true;
    _errorMessage="";
    _objectiveId=objectiveId;
    notifyListeners();
    String accessCode = await _appData.getToken() ?? "";
    try{
      List<Question> questions = await _quizService.getObjectiveQuickQuiz(accessCode: accessCode, objectiveId: objectiveId);
      _questions.clear();
      _questions.addAll(questions);
      if(questions.length ==0){
        throw ValidationException(message: "Question are yet to be loaded for this objective", errors: []);
      }
      _currentQuestionIndex=0;
      _currentQuestion = _questions[_currentQuestionIndex];
      _isLoadingQuestions=false;
      _errorMessage = "";
      _lastQuestionIndex = _questions.length -1;
      _completedQuiz = _currentQuestionIndex == _lastQuestionIndex;
      _numberOfAttemptedQuestions=0;
      _totalCorrectAnswers=0;
      _percentageScore = 0;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingQuestions=false;
      _errorMessage = e.message;
      notifyListeners();
    }catch (e){
      _isLoadingQuestions=false;
      _errorMessage = e.toString().substring(11);
      notifyListeners();
    }
  }

  bool gotoNextQuestions(){
    if(_currentQuestionIndex<_lastQuestionIndex){
      _currentQuestionIndex +=1;
      _currentQuestion = _questions[_currentQuestionIndex];
      _completedQuiz = _currentQuestionIndex == _lastQuestionIndex;
      notifyListeners();
      return true;
    }
    return false;
  }

  void calculateScore(String currentQuestionAnswer){
    if(_numberOfAttemptedQuestions==_questions.length){
      return;
    }
    _numberOfAttemptedQuestions+=1;
    print(currentQuestionAnswer);
    print(_currentQuestion.shortAnswer);
    if(currentQuestionAnswer == _currentQuestion.shortAnswer){
      _totalCorrectAnswers+=1;
    }
    _percentageScore = ((_totalCorrectAnswers/_questions.length) * 100).floor();
    print("totalCorrectAnswers: $_totalCorrectAnswers");
    print("numberOfAttemptedQuestions: $_numberOfAttemptedQuestions");
    print("totalNumberOfQuestions: ${_questions.length}");
  }

  Future<Map<String,dynamic>> submitQuizScore() async {
    String accessCode = await _appData.getToken() ?? "";
    final response = await _quizService.submitObjectiveQuizScore(percentageScore: _percentageScore, objectiveId: _objectiveId, accessCode: accessCode);
    return response;
  }

}