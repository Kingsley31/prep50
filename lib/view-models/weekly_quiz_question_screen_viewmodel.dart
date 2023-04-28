

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prep50/models/question.dart';
import 'package:prep50/models/weekly_quiz.dart';
import 'package:prep50/services/quiz-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

class WeeklyQuizQuestionScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  QuizService _quizService = QuizService();
  Map<String,String> _userAnswers = Map();
  List<Question> _questions=[];
  late Question _currentQuestion;
  bool _isLoadingQuestions = true;
  String _errorMessage = "";
  bool _completedQuiz = false;
  int _currentQuestionIndex = 0;
  int _lastQuestionIndex = 0;
  int _numberOfAttemptedQuestions=0;
  Duration _quizCountDownTime = Duration(minutes: 0);
  bool _quizIsTimedOut=false;
  late Timer _quizTimer;
  int _totalCorrectAnswers = 0;
  int _score=0;

  int get score{
    return _score;
  }

  int get totalCorrectAnswers{
    return _totalCorrectAnswers;
  }

  bool get quizIsTimedOut{
    return _quizIsTimedOut;
  }

  Duration get quizCountDownTime{
    return _quizCountDownTime;
  }

  List<Question> get questions {
    return _questions;
  }


  bool get startScoreCalculation{
    return _numberOfAttemptedQuestions == _questions.length;
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

  void loadQuestions(WeeklyQuiz weeklyQuiz) async {
    _quizIsTimedOut=false;
    _isLoadingQuestions=true;
    _errorMessage="";
    _totalCorrectAnswers=0;
    _score=0;
    notifyListeners();
    try{
      List<Question> questions = weeklyQuiz.questions;
      _questions.clear();
      _questions.addAll(questions);
      if(questions.length ==0){
        throw ValidationException(message: "Question are yet to be loaded for this quiz", errors: []);
      }
      _currentQuestionIndex=0;
      _currentQuestion = _questions[_currentQuestionIndex];
      _isLoadingQuestions=false;
      _errorMessage = "";
      _lastQuestionIndex = _questions.length -1;
      _completedQuiz = _currentQuestionIndex == _lastQuestionIndex;
      _numberOfAttemptedQuestions=0;
      _quizCountDownTime=Duration(minutes: weeklyQuiz.duration);
      startCountDownTiming();
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

  void trackCurrentQuestionAnswer(String currentQuestionAnswer){
    if(_numberOfAttemptedQuestions==_questions.length){
      return;
    }
    _numberOfAttemptedQuestions+=1;
    print(currentQuestionAnswer);
    _userAnswers["${_currentQuestion.id}"]=currentQuestionAnswer;
    if(currentQuestionAnswer == _currentQuestion.shortAnswer){
      _totalCorrectAnswers+=1;
    }

    print("numberOfAttemptedQuestions: $_numberOfAttemptedQuestions");
    print("totalNumberOfQuestions: ${_questions.length}");
  }

  Future<int> submitQuizScore() async {
    _quizTimer.cancel();
    String accessCode = await _appData.getToken() ?? "";
    _score = await _quizService.submitUserWeeklyQuizAnswers(userAnswers: _userAnswers, accessCode: accessCode);
    print(_score);
    return _score;
  }

  startCountDownTiming(){
    _quizTimer=Timer.periodic(new Duration(seconds: 1), (timer) {
      if(_quizCountDownTime.inMinutes>=0){
        _quizCountDownTime=Duration(seconds: (_quizCountDownTime.inSeconds-1));
        notifyListeners();
      }else{
        _quizIsTimedOut=true;
        notifyListeners();
      }
    });
  }


  void stopTimer() {
    _quizTimer.cancel();
  }



}