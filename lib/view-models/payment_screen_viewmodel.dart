
import 'package:flutter/material.dart';
import 'package:prep50/models/payment_response.dart';
import 'package:prep50/services/payment_service.dart';


class PaymentScreenViewModel extends ChangeNotifier{
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
    print("called verify payment");
    print("Reference: $paymentReference");
    print("Payment type: $paymentType");
    _isLoading=true;
    notifyListeners();
    PaymentResponse paymentResponse = await _paymentService.verifyPayment(type: paymentType, reference: paymentReference);
    print("payment status prep50: ${paymentResponse.status}");
    _isLoading=false;
    notifyListeners();
    return paymentResponse.status=="success";
  }

}