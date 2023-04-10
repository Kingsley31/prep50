
import '../widgets/app_dialog.dart';

class ThirdPartyLoginInfo{
  String username;
  String email;
  String phoneNumber;

  ThirdPartyLoginInfo({required this.username,required this.email,required this.phoneNumber});
}
class ThirdPartyLoginInfoValidator{

  static Future<ThirdPartyLoginInfo> validate(context,String? username,String? email,String? phoneNumber) async {
    String userName = "";
    String userEmail = "";
    String userPhoneNumber = "";

    if(username == null || username.isEmpty){
      userName = await AppDialog.showInputDialog(context,InputDialogType.USERNAME) ?? "";
    }else{
      userName = username;
    }

    if(email == null || email.isEmpty){
      userEmail = await AppDialog.showInputDialog(context,InputDialogType.EMAIL) ?? "";
    }else{
      userEmail = email;
    }

    if(phoneNumber == null || phoneNumber.isEmpty){
      userPhoneNumber = await AppDialog.showInputDialog(context,InputDialogType.PHONE) ?? "";
    }else{
      userPhoneNumber = phoneNumber;
    }

    return ThirdPartyLoginInfo(username: userName, email: userEmail, phoneNumber: userPhoneNumber);
  }
}