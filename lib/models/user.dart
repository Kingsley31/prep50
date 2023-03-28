
class User{
  String? username;
  String? email;
  String? phone;
  String? photo;
  String? referral;

  User({this.username, this.email,this.phone,this.photo});


  User.fromJson(Map<String,dynamic> json){
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    photo = json["photo"];
    referral = json["referral"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;
    data["username"] = this.username;
    data["photo"] = this.photo;
    data["phone"] = this.photo;
    data["referral"] = this.referral;
    return data;
  }

}