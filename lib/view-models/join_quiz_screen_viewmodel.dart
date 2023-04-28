
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:prep50/models/weekly_quiz.dart';
import 'package:prep50/services/quiz-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

class JoinQuizScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  QuizService _quizService = QuizService();
  bool _showJoinQuizButton = false;
  bool _isLoadingWeeklyQuiz =false;
  String _weeklyQuizNotice = "";
  String _errorMessage = "";
  WeeklyQuiz _weeklyQuiz = WeeklyQuiz("", 0, "", 0, "", 0, 0, false, []);
  DateTime _startTime = DateTime.now();//DateTime(2023,4,24,9,30)
  Duration _countDown = Duration(days:0,hours: 0,minutes: 0,seconds: 0);

  WeeklyQuiz get weeklyQuiz {
    return _weeklyQuiz;
  }

  bool get showJoinQuizButton{
    return _showJoinQuizButton;
  }

  bool get isLoadingWeeklyQuiz{
    return _isLoadingWeeklyQuiz;
  }

  String get errorMessage{
    return _errorMessage;
  }

  String get weeklyQuizNotice{
    return _weeklyQuizNotice;
  }

  Duration get countDown{
    return _countDown;
  }

  loadWeekLyQuiz()async{
    String accessCode = await _appData.getToken()??"";
    try{
      _isLoadingWeeklyQuiz = true;
      _weeklyQuizNotice = "";
      _errorMessage = "";
      notifyListeners();
      _weeklyQuiz=await _quizService.getWeeklyQuiz(accessCode: accessCode);
      _startTime = DateTime.parse(_weeklyQuiz.startTime).toLocal();
      final DateTime now = DateTime.now();
      _showJoinQuizButton = _startTime.isBefore(now);
      if(_startTime.isAfter(now)){
        startCountDownTiming();
      }
      _isLoadingWeeklyQuiz = false;
      notifyListeners();
    } on WeeklyQuizException catch(e){
      _isLoadingWeeklyQuiz = false;
      _weeklyQuizNotice = e.message;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingWeeklyQuiz=false;
      _errorMessage = e.message;
      notifyListeners();
    }catch (e){
      _isLoadingWeeklyQuiz=false;
      _errorMessage = e.toString().substring(11);
      print(e.toString());
      notifyListeners();
    }

  }

  startCountDownTiming(){
    Timer.periodic(new Duration(seconds: 1), (timer) {
      final DateTime now = DateTime.now();
      if(_startTime.isAfter(now)){
          _countDown = _startTime.difference(now);
          print(_countDown.inSeconds);
          notifyListeners();
      }else{
        _showJoinQuizButton = _startTime.isBefore(now);
        notifyListeners();
      }
    });
  }
}