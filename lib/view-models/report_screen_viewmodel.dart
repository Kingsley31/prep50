
import 'package:flutter/cupertino.dart';
import 'package:prep50/services/new_feed_service.dart';
import 'package:prep50/storage/app_data.dart';

class ReportScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  NewsFeedService _newsFeedService = NewsFeedService();

  Future<Map<String,dynamic>> reportFeed(String type,String slug, String message)async{
    String accessCode = await _appData.getToken()??"";
    return await _newsFeedService.reportPost(slug: slug, type: type.toLowerCase(), message: message, accessCode: accessCode);
  }

  Future<Map<String,dynamic>> reportComment(String type,String commentId, String message)async{
    String accessCode = await _appData.getToken()??"";
    return await _newsFeedService.reportComment(type: type, commentId: commentId, message: message, accessCode: accessCode);
  }
}