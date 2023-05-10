
import 'package:flutter/material.dart';

import '../services/system_info_services.dart';
import '../storage/app_data.dart';
import '../utils/exceptions.dart';

class TermsOfServiceScreenViewModel extends ChangeNotifier{
  SystemInfoServices _systemInfoServices = SystemInfoServices();
  AppData _appData = AppData();
  String _termsOfServiceMarkdown ="";
  bool _isLoadingTermsOfService = false;
  String _errorMessage="";

  String get termsOfServiceMarkdown{
    return _termsOfServiceMarkdown;
  }

  String get errorMessage{
    return _errorMessage;
  }

  bool get isLoadingTermsOfService{
    return _isLoadingTermsOfService;
  }

  loadTerOfService()async{
    _isLoadingTermsOfService=true;
    _errorMessage="";
    notifyListeners();
    final String accessCode = await _appData.getToken()??"";
    try{
      _termsOfServiceMarkdown = await _systemInfoServices.getTermsOfService(accessCode: accessCode);
      _isLoadingTermsOfService=false;
      notifyListeners();
    }on ValidationException catch(e){
      _errorMessage = e.message;
      _isLoadingTermsOfService=false;
      notifyListeners();
    }catch (e){
      _errorMessage = e.toString().substring(11);
      _isLoadingTermsOfService=false;
      notifyListeners();
    }

  }

}