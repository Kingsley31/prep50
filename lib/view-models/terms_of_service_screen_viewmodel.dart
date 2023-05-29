
import 'package:flutter/material.dart';

import '../services/system_info_services.dart';
import '../utils/exceptions.dart';

class TermsOfServiceScreenViewModel extends ChangeNotifier{
  SystemInfoServices _systemInfoServices = SystemInfoServices();
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
    try{
      _termsOfServiceMarkdown = await _systemInfoServices.getTermsOfService();
      _isLoadingTermsOfService=false;
      notifyListeners();
    }on LoginException catch(e){
      _errorMessage = e.message;
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