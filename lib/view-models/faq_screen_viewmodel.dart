
import 'package:flutter/material.dart';
import 'package:prep50/storage/app_data.dart';

import '../models/faq.dart';
import '../services/system_info_services.dart';
import '../utils/exceptions.dart';

class FaqScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  SystemInfoServices _systemInfoServices = SystemInfoServices();
  List<Faq> _faqList = [];
  String _errorMessage = "";
  bool _isLoadingFaqList = false;

  List<Faq> get faqList {
    return _faqList;
  }

  bool get isLoadingFaqList {
    return _isLoadingFaqList;
  }

  String get errorMessage{
    return _errorMessage;
  }


  loadFaqList()async{
    _isLoadingFaqList=true;
    _errorMessage = "";
    notifyListeners();
    String accessCode = await _appData.getToken()??"";
    try{
      _faqList=await _systemInfoServices.getFaqList(accessCode: accessCode);
      _isLoadingFaqList=false;
      notifyListeners();
    }on ValidationException catch(e){
      _errorMessage = e.message;
      _isLoadingFaqList=false;
      notifyListeners();
    }catch (e){
      _errorMessage = e.toString().substring(11);
      _isLoadingFaqList=false;
      notifyListeners();
    }

  }
}