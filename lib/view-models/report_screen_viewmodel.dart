
import 'package:flutter/cupertino.dart';
import 'package:prep50/services/new_feed_service.dart';

class ReportScreenViewModel extends ChangeNotifier{
  NewsFeedService _newsFeedService = NewsFeedService();

  Future<Map<String,dynamic>> reportFeed(String type,String slug, String message)async{
    return await _newsFeedService.reportPost(slug: slug, type: type.toLowerCase(), message: message);
  }

  Future<Map<String,dynamic>> reportComment(String type,String commentId, String message)async{
    return await _newsFeedService.reportComment(type: type, commentId: commentId, message: message);
  }
}