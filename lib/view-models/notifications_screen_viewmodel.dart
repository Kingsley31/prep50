
import 'package:flutter/material.dart';
import 'package:prep50/services/notification_service.dart';
import 'package:prep50/storage/app_data.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/notification_list_item.dart';

class NotificationsScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  NotificationService _notificationService = NotificationService();
  List<NotificationListItem> _notificationList = [];
  bool _isLoadingNotifications = false;
  String _errorMessage="";

  List<NotificationListItem> get notificationList{
    return _notificationList;
  }

  bool get isLoadingNotifications{
    return _isLoadingNotifications;
  }

  String get errorMessage{
    return _errorMessage;
  }

  loadNotifications()async{
    _isLoadingNotifications=true;
    _errorMessage="";
    notifyListeners();
    String accessCode = await _appData.getToken()??"";
    try{
      _notificationList = await _notificationService.getAllUserNotifications(accessCode: accessCode);
      _notificationList.add(NotificationListItem("", "", "", "", "", false));
      _isLoadingNotifications=false;
      notifyListeners();
    }on ValidationException catch(e){
      _errorMessage=e.message;
      _isLoadingNotifications=false;
      notifyListeners();
    }catch(e){
      _errorMessage=e.toString().substring(11);
      _isLoadingNotifications=false;
      notifyListeners();
    }
  }
}