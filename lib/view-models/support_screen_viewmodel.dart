
import 'package:flutter/cupertino.dart';
import 'package:prep50/models/support_contact.dart';
import 'package:prep50/services/system_info_services.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

class SupportScreenViewModel extends ChangeNotifier{
  AppData _appData=AppData();
  SystemInfoServices _systemInfoServices = SystemInfoServices();
  SupportContact _supportContact = SupportContact("", "", "", "");
  bool _isLoadingSupportContact = false;
  String _errorMessage = "";

  bool get isLoadingSupportContact{
    return _isLoadingSupportContact;
  }

  String get errorMessage{
    return _errorMessage;
  }

  SupportContact get supportContact{
    return _supportContact;
  }

  loadSupportContact()async{
    _isLoadingSupportContact=true;
    _errorMessage = "";
    notifyListeners();
    String accessCode = await _appData.getToken()??"";
    try{
      _supportContact=await _systemInfoServices.getSupportContact(accessCode: accessCode);
      _isLoadingSupportContact=false;
      notifyListeners();
    }on ValidationException catch(e){
      _errorMessage = e.message;
      _isLoadingSupportContact=false;
      notifyListeners();
    }catch (e){
      _errorMessage = e.toString().substring(11);
      _isLoadingSupportContact=false;
      notifyListeners();
    }

  }
}