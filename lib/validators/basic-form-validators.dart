import 'package:prep50/utils/email_validator.dart';

String? nameValidator(String? name){
   if(name==null || name.isEmpty){
    return "Please enter a valid username";
   }

   if(name.contains(" ")){
     return "Username must not contain space";
   }

   return null;
 }

String? addressValidator(String? address){
  if(address==null || address.isEmpty){
    return "Please enter a valid address";
  }
  return null;
}

String? phoneNumberValidator(String? phoneNumber){
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (phoneNumber==null || phoneNumber.isEmpty) {
    return 'Please enter mobile number';
  }
  else if (!regExp.hasMatch(phoneNumber)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

 String? emailValidator(String? email){
  if(email==null || email.isEmpty || !EmailValidator.validate(email)){
    return "Please enter a valid email";
  }
  return null;
 }

String? passwordValidator(String? password){
  if(password==null || password.isEmpty){
    return "Please enter a valid password";
  }
  else if(password.length<5){
    return "Password shouldn't be less than 5 characters";
  }
  return null;
 }