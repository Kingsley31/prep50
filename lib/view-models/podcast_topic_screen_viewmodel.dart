
import 'package:flutter/cupertino.dart';
import 'package:prep50/models/podcast_topic.dart';

import '../models/podcast.dart';
import '../services/subject-service.dart';
import '../storage/app_data.dart';
import '../utils/exceptions.dart';

class PodcastTopicScreenViewModel extends ChangeNotifier{
  bool _isLoadingTopics = false;
  bool _hasError = false;
  String _errorMessage="";
  List<PodcastTopic> _topicList = [];
  List<PodcastTopic> _allTopicList = [];
  AppData _appData = AppData();
  SubjectService _subjectService = SubjectService();

  bool get hasError {
    return _hasError;
  }

  String get errorMessage{
    return _errorMessage;
  }

  bool get isLoadingTopic {
    return _isLoadingTopics;
  }

  List<PodcastTopic> get topicList {
    return _topicList;
  }

  void loadTopics(int subjectId) async {
    _isLoadingTopics = true;
    _hasError=false;
    notifyListeners();
    try{
      List<PodcastTopic> topicList = await _subjectService.getSubjectTopicsAndPodcasts(subjectId);
      _topicList.clear();
      _topicList.addAll(topicList);
      _allTopicList.clear();
      _allTopicList.addAll(topicList);
      _isLoadingTopics=false;
      notifyListeners();
    }on LoginException catch(e){
      _hasError=true;
      _errorMessage=e.message;
      notifyListeners();
    } on ValidationException catch(e){
      _hasError=true;
      _errorMessage=e.message;
      notifyListeners();
    } catch (e){
      _hasError=true;
      _errorMessage=e.toString();
      notifyListeners();
    }

  }

  void searchTopic(String searchString) {
    if(searchString.isNotEmpty){
      List<PodcastTopic> foundTopics = _topicList.where((topic) => topic.title.toLowerCase().contains(searchString.toLowerCase()) || _podcastsContainsString(searchString.toLowerCase(),topic.podcasts) ).toList();
      _topicList.clear();
      _topicList.addAll(foundTopics);
      notifyListeners();
    }else{
      _topicList.clear();
      _topicList.addAll(_allTopicList);
      notifyListeners();
    }
  }

  bool _podcastsContainsString(String searchString,List<Podcast> podcasts) {
    return podcasts.any((podcast) => podcast.title.toLowerCase().contains(searchString));
  }

  Future<List<PodcastTopic>> getFavouriteTopics(int subjectId) async {
    List<PodcastTopic> topics = await _appData.getUserSubjectFavouriteTopics(subjectId);
    return topics;
  }


}