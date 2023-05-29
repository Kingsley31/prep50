
import 'package:flutter/material.dart';
import 'package:prep50/models/payment_response.dart';
import 'package:prep50/services/payment_service.dart';
import 'package:prep50/services/paystack/models/payment_verification_response.dart';
import 'package:prep50/services/paystack/paystack_api_service.dart';


class PaymentScreenViewModel extends ChangeNotifier{
  PaystackApiService _paystackApiService= PaystackApiService();
  PaymentService _paymentService = PaymentService();
  bool _isLoading = false;
  bool _pageLoaded=false;


  bool get isLoading{
    return _isLoading;
  }

  bool get pageLoaded{
    return _pageLoaded;
  }

  set isLoading(bool loading){
    if(_pageLoaded==false && loading==false){
      _pageLoaded=true;
    }
    if(loading!=_isLoading){
      _isLoading=loading;
      notifyListeners();
    }
  }





  Future<bool> verifyPayment({required String paymentType,required String paymentReference})async{
    _isLoading=true;
    notifyListeners();
    PaymentVerificationResponse paymentVerificationResponse=await _paystackApiService.verifyPayment(reference: paymentReference);
    print("payment status paystack: ${paymentVerificationResponse.data.status}");
    if(paymentVerificationResponse.data.status=="success"){
      PaymentResponse paymentResponse = await _paymentService.verifyPayment(type: paymentType, reference: paymentReference);
      print("payment status prep50: ${paymentResponse.status}");
      _isLoading=false;
      notifyListeners();
      return paymentResponse.status=="success";
    }
    _isLoading=false;
    notifyListeners();
    return false;
  }

}