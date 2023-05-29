
import 'package:flutter/material.dart';
import 'package:prep50/constants/string_data.dart';
import 'package:prep50/models/user_exam.dart';
import 'package:prep50/services/user-exam-service.dart';
import 'package:prep50/utils/exceptions.dart';
import 'package:prep50/utils/prep50_api_utils.dart';

import '../models/exam_board.dart';
import '../models/user.dart';
import '../services/exam-board-service.dart';
import '../services/paystack/models/payment_initialization_response.dart';
import '../services/paystack/paystack_api_service.dart';
import '../storage/app_data.dart';

class SubscriptionScreenViewModel extends ChangeNotifier{
  String _UTME_AND_SSCE_TITLE = "UTME and SSCE Premium Service";
  String _UTME_TITLE = "UTME Premuim Service";
  String _SSCE_TITLE = "SSCE Premuim Service";
  AppData _appData = AppData();
  PaystackApiService _paystackApiService= PaystackApiService();
  final UserExamService _userExamService = UserExamService();
  final ExamBoardService _examBoardService = ExamBoardService();
  List<UserExam> _userExamList = [];
  String _subscriptionTitle="";
  String _errorMessage="";
  bool _isLoadingUserExams=false;
  double _amount=0;
  bool _showSubscribeNowButton=false;
  String _paymentType="";
  String _authorizationUrl="";
  String _paymentReference = "";

  String get paymentReference{
    return _paymentReference;
  }

  String get authorizationUrl{
    return _authorizationUrl;
  }

  String get subscriptionTitle{
    return _subscriptionTitle;
  }

  String get errorMessage{
    return _errorMessage;
  }

  double get amount{
    return _amount;
  }

  bool get isLoadingUserExams{
    return _isLoadingUserExams;
  }

  bool get showSubscribeNowButton{
    return _showSubscribeNowButton;
  }

  String get paymentType{
    return _paymentType;
  }

  loadSubscriptionData()async{
    _isLoadingUserExams=true;
    _errorMessage="";
    notifyListeners();
    try{
      _userExamList=await _userExamService.getUserExams();
      List<ExamBoard> _allExamBoards = await _examBoardService.getAllExamBoards();
      _showSubscribeNowButton=checkShouldTakeUserToSubscriptionScreen(_userExamList);
      _subscriptionTitle=_getSubscriptionTitlte(_userExamList);
      _paymentType=_getPaymentType(_userExamList);
      _amount = _getSubscriptionAmount(_userExamList,_allExamBoards);
      if(_showSubscribeNowButton){
        final userJson = await _appData.getUser();
        final User user = User.fromJson(userJson!);
        String paymentAmount = (_amount*100).toString();
        PaymentInitializationResponse paymentInitializationResponse= await _paystackApiService.initializePayment(email: user.email!, amount: paymentAmount);
        _authorizationUrl=paymentInitializationResponse.data.authorizationUrl;
        _paymentReference=paymentInitializationResponse.data.reference;
      }
      _isLoadingUserExams=false;
      notifyListeners();
    }on LoginException catch(e){
      _isLoadingUserExams=false;
      _errorMessage=e.message;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingUserExams=false;
      _errorMessage=e.message;
      notifyListeners();
    }catch (e){
      _isLoadingUserExams=false;
      _errorMessage=e.toString().substring(11);
      notifyListeners();
    }
  }

  String _getSubscriptionTitlte(List<UserExam> userExamList) {
    if(userExamList.length>1){
      _paymentType=BOTH_JAMB_AND_WAEC_EXAM_BOARDS;
      return _UTME_AND_SSCE_TITLE;
    }
    if(userExamList[0].exam.toLowerCase()==JAMB_EXAM_BOARD){
      _paymentType=JAMB_EXAM_BOARD;
      return _UTME_TITLE;
    }
    _paymentType=WAEC_EXAM_BOARD;
    return _SSCE_TITLE;
  }

  String _getPaymentType(List<UserExam> userExamList) {
    if(userExamList.length>1){
      return BOTH_JAMB_AND_WAEC_EXAM_BOARDS;
    }
    if(userExamList[0].exam.toLowerCase()==JAMB_EXAM_BOARD){
      return JAMB_EXAM_BOARD;
    }
    return WAEC_EXAM_BOARD;
  }

  double _getSubscriptionAmount(List<UserExam> userExamList,List<ExamBoard> allExamBoards) {
    double amount=0;
    userExamList.forEach((userExam) {
      ExamBoard selectedExamBoard=allExamBoards.firstWhere((element) => element.name.toLowerCase()==userExam.exam.toLowerCase());
      amount+=selectedExamBoard.price;
    });
    return amount;
  }
}