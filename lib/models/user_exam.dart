
class UserExam{
  String? id;
  String exam;
  int session;
  String paymentStatus;
  String createdAt;



  UserExam({this.id,this.exam="",required this.session,required this.paymentStatus, required this.createdAt});

  UserExam.fromJson(Map<String, dynamic> json):
        id = json.containsKey("id") ? json['id']:null,
        exam = json.containsKey("exam") ? json['exam']:"",
        session = json["session"],
        paymentStatus = json["payment_status"],
        createdAt = json["created_at"];


  Map<String, dynamic> toJson() => {
    'id': id,
    'exam':exam,
    'session':session,
    'payment_status':paymentStatus,
    'created_at':createdAt
  };
}