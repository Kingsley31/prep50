
import 'package:flutter/foundation.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/exam_board.dart';
import '../services/exam-board-service.dart';

class ExamBoardBottomSheetViewModel extends ChangeNotifier{
  final ExamBoardService _examBoardService = ExamBoardService();
  List<ExamBoard> _examBoardList = [];
  bool _isLoadingExamBoard=false;
  String _errorMessage = "";

  String get errorMessage{
    return _errorMessage;
  }
  bool get isLoadingExamBoard{
    return _isLoadingExamBoard;
  }

  List<ExamBoard> get examBoardList{
    return _examBoardList;
  }

  loadExamBoard()async{
    _isLoadingExamBoard=true;
    _errorMessage="";
    notifyListeners();
    try{
      _examBoardList= await _examBoardService.getAllExamBoards();
      _isLoadingExamBoard=false;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingExamBoard=false;
      _errorMessage=e.message;
      notifyListeners();
    }catch(e){
      _isLoadingExamBoard=false;
      _errorMessage=e.toString().substring(11);
      notifyListeners();
    }
  }
}