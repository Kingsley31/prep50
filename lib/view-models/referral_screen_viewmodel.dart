
import 'package:flutter/cupertino.dart';
import 'package:prep50/storage/app_data.dart';

import '../models/user.dart';
import '../utils/deeplink_utils.dart';

class ReferralScreenViewModel extends ChangeNotifier{
  AppData _appData= AppData();
  String _referralLink = "";
  String _errorMessage="";
  bool _isLoadingLink=false;

  String get referralLink{
    return _referralLink;
  }

  String get errorMessage{
    return _errorMessage;
  }

  bool get isLoadingLink{
    return _isLoadingLink;
  }

  loadReferralLink()async{
    _isLoadingLink=true;
    _errorMessage = "";
    notifyListeners();
    final userJson = await _appData.getUser();
    try{
      User user = User.fromJson(userJson!);
      _referralLink=await buildRefererLink(user.username!);
      _isLoadingLink=false;
      notifyListeners();
    }catch(e){
      _isLoadingLink=false;
      _errorMessage="unable to load referral link please ensure your device is online and try again";
      notifyListeners();
    }
  }
}