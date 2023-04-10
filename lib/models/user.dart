
import 'package:prep50/models/user_exam.dart';

class User{
  String? username;
  String? email;
  String? phone;
  String? photo;
  String? referral;
  String? gender;
  bool hasRegisteredExam;
  List<UserExam>? exams;

  User({this.username, this.email,this.phone,this.photo,this.referral,this.gender,this.exams,this.hasRegisteredExam=false});


  User.fromJson(Map<String,dynamic> json) :
    username = json["username"],
    email = json["email"],
    phone = json["phone"],
    photo = json["photo"],
    referral = json["referral"],
    gender = json.containsKey("gender") ? json["gender"]:null,
    hasRegisteredExam = json.containsKey("has_registered_exam") ? json["has_registered_exam"] : false,
    exams = json.containsKey("exams") ? json["exams"].map<UserExam>((examJson) => UserExam.fromJson(examJson)).toList():null;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;
    data["username"] = this.username;
    data["photo"] = this.photo;
    data["phone"] = this.photo;
    data["referral"] = this.referral;
    data["gender"] = this.gender;
    data["has_registered_exam"] = hasRegisteredExam;
    data["exams"] = exams != null ? exams?.map<Map<String,dynamic>>((exam) => exam.toJson()).toList() : null;
    return data;
  }

}