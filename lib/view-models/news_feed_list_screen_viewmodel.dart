

import 'package:flutter/material.dart';
import 'package:prep50/models/news_feed_filter.dart';
import 'package:prep50/models/news_feed_list_item.dart';
import 'package:prep50/services/new_feed_service.dart';
import 'package:prep50/utils/exceptions.dart';

class NewsFeedListScreenViewModel extends ChangeNotifier{
  NewsFeedService _newsFeedService = NewsFeedService();
  NewsFeedFilter _feedFilter=NewsFeedFilter(1,1,0);
  List<NewsFeedListItem> _newsFeedList = [];
  List<NewsFeedListItem> _allNewsFeedList = [];
  bool _isLoadingFeeds = false;
  String _feedErrorMessage = "";

  bool get isLoadingFeeds{
    return _isLoadingFeeds;
  }

  String get feedErrorMessage{
    return _feedErrorMessage;
  }

  set feedFilter(NewsFeedFilter newsFeedFilter){
    _feedFilter = newsFeedFilter;
    notifyListeners();
  }

  NewsFeedFilter get feedFilter{
    return _feedFilter;
  }

  List<NewsFeedListItem> get newsFeedList{
    return _newsFeedList;
  }

  searchNewsFeed(String searchString){
    if(searchString.isEmpty){
      _newsFeedList.clear();
      _newsFeedList.addAll(_allNewsFeedList);
      notifyListeners();
      return;
    }
    _newsFeedList.retainWhere((feed) => feed.content.toLowerCase().contains(searchString.toLowerCase()));
    notifyListeners();
  }

  loadNewsFeedList()async{
    _isLoadingFeeds=true;
    _feedErrorMessage="";
    notifyListeners();
    try{
      _newsFeedList.clear();
      _allNewsFeedList.clear();
      _newsFeedList = await _newsFeedService.getNewsFeedItemList(filter: _feedFilter);
      _allNewsFeedList.addAll(_newsFeedList);
      _isLoadingFeeds=false;
      notifyListeners();
    }on LoginException catch(e){
      _isLoadingFeeds=false;
      _feedErrorMessage=e.message;
      notifyListeners();
    }on ValidationException catch(e){
      _isLoadingFeeds=false;
      _feedErrorMessage=e.message;
      notifyListeners();
    }catch(e){
      _isLoadingFeeds=false;
      _feedErrorMessage=e.toString().substring(11);
      notifyListeners();
    }

  }

  likeFeed(String slug,bool liked)async{
    await _newsFeedService.likePost(slug: slug, liked: liked);
  }

  bookmarkFeed(String slug,bool bookmarked)async{
    await _newsFeedService.bookMarkPost(slug: slug, bookmarked: bookmarked);
  }

}