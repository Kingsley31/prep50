
import 'package:prep50/models/payment_initialization_data.dart';

class PaymentInitializationResponse{
  String status;
  PaymentInitializationData data;

  PaymentInitializationResponse({required this.status,required this.data});

  PaymentInitializationResponse.fromJson(Map<String,dynamic> json):
        status=json["status"],
        data= PaymentInitializationData.fromJson(json["data"]);

  Map<String,dynamic> toJson() => {
    "status":status,
    "data":data.toJson()
  };
}