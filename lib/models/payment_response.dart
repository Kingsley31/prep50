
class PaymentResponse{
  String message;
  String status;

  PaymentResponse({required this.message,required this.status});

  PaymentResponse.fromJson(Map<String,dynamic> json):
       message = json["message"],
       status = json["status"];


  Map<String,dynamic> toJson() => {
    "message":message,
    "status":status
  };
}