
import 'package:flutter/material.dart';
import 'package:prep50/services/quiz-service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/weekly_quiz_participant.dart';

class WeeklyQuizLeaderBoardScreenViewModel extends ChangeNotifier{
  AppData _appData= AppData();
  QuizService _quizService = QuizService();
  List<WeeklyQuizParticipant> _leaderBoard=[];
  WeeklyQuizParticipant? _highestScoreParticipant;
  WeeklyQuizParticipant? _secondHighestScoreParticipant;
  WeeklyQuizParticipant? _thirdHighestScoreParticipant;
  bool _isLoadingLeaderBoard = false;
  String _errorMessage = "";

  WeeklyQuizParticipant? get highestScoreParticipant{
    return _highestScoreParticipant;
  }

  WeeklyQuizParticipant? get secondHighestScoreParticipant{
    return _secondHighestScoreParticipant;
  }

  WeeklyQuizParticipant? get thirdHighestScoreParticipant{
    return _thirdHighestScoreParticipant;
  }

  bool get isLoadingLeaderBoard{
    return _isLoadingLeaderBoard;
  }

  List<WeeklyQuizParticipant> get leaderBoard{
    return _leaderBoard;
  }

  String get errorMessage{
      return _errorMessage;
  }

  loadLeaderBoard()async{
    String accessCode =  await _appData.getToken() ?? "";
     _isLoadingLeaderBoard = true;
     _errorMessage="";
     notifyListeners();
     try{
       _leaderBoard=await _quizService.getLeaderBoard(accessCode: accessCode);
       _leaderBoard.sort((participantA,participantB)=> participantB.score.compareTo(participantA.score));
       if(_leaderBoard.isNotEmpty){
         _highestScoreParticipant = _leaderBoard[0];
       }
       if(_leaderBoard.length>1){
         _secondHighestScoreParticipant=_leaderBoard[1];
       }
       if(_leaderBoard.length>2){
         _thirdHighestScoreParticipant=_leaderBoard[2];
       }
       _isLoadingLeaderBoard = false;
       notifyListeners();
     }on ValidationException catch(e){
       _errorMessage = e.message;
       _isLoadingLeaderBoard = false;
       notifyListeners();
     }catch(e){
       _errorMessage = e.toString().substring(11);
       _isLoadingLeaderBoard = false;
       notifyListeners();
     }

  }

}