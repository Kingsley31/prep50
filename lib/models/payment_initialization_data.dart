
class PaymentInitializationData{
  String authorizationUrl;
  String accessCode;
  String reference;

  PaymentInitializationData({required this.authorizationUrl,required this.accessCode,required this.reference});

  PaymentInitializationData.fromJson(Map<String,dynamic> json):
        authorizationUrl=json["authorization_url"],
        accessCode = json["access_code"],
        reference = json["reference"];

  Map<String,dynamic> toJson() => {
    "authorization_url":authorizationUrl,
    "access_code":accessCode,
    "reference":reference
  };
}