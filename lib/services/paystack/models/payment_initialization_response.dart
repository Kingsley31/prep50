


import 'package:prep50/services/paystack/models/payment_initialization_data.dart';

class PaymentInitializationResponse{
  bool status;
  String message;
  PaymentInitializationData data;

  PaymentInitializationResponse({required this.status,required this.message, required this.data});

  PaymentInitializationResponse.fromJson(Map<String,dynamic> json):
      status=json["status"],
      message=json["message"],
      data= PaymentInitializationData.fromJson(json["data"]);

  Map<String,dynamic> toJson() => {
    "status":status,
    "message":message,
    "data":data.toJson()
  };
  
}