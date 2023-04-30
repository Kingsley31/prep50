
import 'package:flutter/widgets.dart';
import 'package:prep50/models/news_feed.dart';
import 'package:prep50/utils/exceptions.dart';

import '../services/new_feed_service.dart';
import '../storage/app_data.dart';

class SingleFeedScreenViewModel extends ChangeNotifier{
  AppData _appData = AppData();
  NewsFeedService _newsFeedService = NewsFeedService();
  NewsFeed _newsFeed = NewsFeed("", "", "", "", "", "", 0, false, false, []);
  bool _isLoadingFeed = false;
  String _errorMessage = "";

  String get errorMessage{
    return _errorMessage;
  }

  bool get isLoadingFeed{
    return _isLoadingFeed;
  }

  NewsFeed get newsFeed{
    return _newsFeed;
  }

  loadNewsFeed(String slug)async{
    String accessCode = await _appData.getToken()??"";
    _isLoadingFeed=true;
    _errorMessage="";
    notifyListeners();
    try{
      _newsFeed= await _newsFeedService.getNewsFeed(slug: slug, accessCode: accessCode);
      _isLoadingFeed=false;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingFeed=false;
      _errorMessage=e.message;
      notifyListeners();
    }catch(e){
      print(e.toString());
      _isLoadingFeed=false;
      _errorMessage=e.toString().substring(11);
      notifyListeners();
    }
  }

  Future<Map<String,dynamic>> postComment(String comment,String slug)async{
    String accessCode = await _appData.getToken()??"";
    return await _newsFeedService.postComment(slug: slug, comment: comment, accessCode: accessCode);
  }

}