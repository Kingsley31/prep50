

import 'package:flutter/material.dart';
import 'package:prep50/models/objective.dart';
import 'package:prep50/services/subject-service.dart';
import 'package:prep50/utils/exceptions.dart';

import '../models/topic.dart';

class TopicScreenViewModel extends ChangeNotifier{
  bool _isLoadingTopics = false;
  bool _hasError = false;
  String _errorMessage="";
  List<Topic> _topicList = [];
  List<Topic> _allTopicList = [];
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

  List<Topic> get topicList {
    return _topicList;
  }

  void loadTopics(int subjectId) async {
    _isLoadingTopics = true;
    _hasError=false;
    notifyListeners();
    try{
      List<Topic> topicList = await _subjectService.getSubjectTopicsAndLessons(subjectId);
      _topicList.clear();
      _topicList.addAll(topicList);
      _allTopicList.clear();
      _allTopicList.addAll(topicList);
      _isLoadingTopics=false;
      notifyListeners();
    } on LoginException catch(e){
      _hasError=true;
      _errorMessage=e.message;
      notifyListeners();
    }on ValidationException catch(e){
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
      List<Topic> foundTopics = _topicList.where((topic) => topic.title.toLowerCase().contains(searchString.toLowerCase()) || _objectivesContainsString(searchString.toLowerCase(),topic.objectives) ).toList();
      _topicList.clear();
      _topicList.addAll(foundTopics);
      notifyListeners();
    }else{
      _topicList.clear();
      _topicList.addAll(_allTopicList);
      notifyListeners();
    }
  }

  bool _objectivesContainsString(String searchString,List<Objective> objectives) {
    return objectives.any((objective) => objective.title.toLowerCase().contains(searchString));
  }


}