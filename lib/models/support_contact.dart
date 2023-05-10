

class SupportContact{
  String email;
  String location;
  String phone;
  String website;

  SupportContact(this.email,this.location,this.phone,this.website);

  SupportContact.fromJson(Map<String,dynamic> json):
      email=json["email"],
      location=json["location"],
      phone=json["phone"],
      website=json["website"];


  toJson()=>{
    "email":email,
    "location":location,
    "phone":phone,
    "website":website
  };
}