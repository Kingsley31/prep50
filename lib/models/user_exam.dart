
class UserExam{
  String? id;
  String exam;
  int session;
  String paymentStatus;
  String createdAt;
  String expiryDate;



  UserExam({this.id,this.exam="",required this.session,required this.paymentStatus, required this.createdAt,required this.expiryDate});

  UserExam.fromJson(Map<String, dynamic> json):
        id = json.containsKey("id") ? json['id']:null,
        exam = json.containsKey("exam") ? json['exam']:"",
        session = json["session"],
        paymentStatus = json["payment_status"],
        expiryDate=json.containsKey("expires_at") ? json["expires_at"]??"":"",
        createdAt = json["created_at"];


  Map<String, dynamic> toJson() => {
    'id': id,
    'exam':exam,
    'session':session,
    'payment_status':paymentStatus,
    'expires_at':expiryDate,
    'created_at':createdAt
  };
}