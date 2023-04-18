
import 'package:flutter/material.dart';
import 'package:prep50/models/objective.dart';
import 'package:prep50/models/topic.dart';

import '../models/lesson.dart';

class StudyScreenViewModel extends ChangeNotifier{
  Topic _currentTopic=Topic(0, 0, "", "", []);
  Objective _currentObjective = Objective(id: 0, title: "", details: "", lessons: [Lesson(id: 0, subjectId: 0, objectiveId: 0, title: "", content: "Loading..", videoUrl: "", slideUrl: "", docsUrl: "", createdAt: "", updateAt: "")], progress: 0);
  int _currentLessonIndex = 0;
  int _totalLessons = 0;
  bool _completedLessons = true;


  bool get completedLessons{
    return _completedLessons;
  }
  set currentTopic(Topic topic){
    _currentTopic = topic;
    notifyListeners();
  }

  Objective get currentObjective{
    return _currentObjective;
  }

  set currentObjective(Objective objective){
    print(objective.lessons.length);
    _currentObjective = objective;
    _totalLessons = objective.lessons.length - 1;
    _currentLessonIndex = 0;
    _completedLessons = _currentLessonIndex == _totalLessons;
    notifyListeners();
  }

  Lesson get currentLesson{
    return _currentObjective.lessons[_currentLessonIndex];
  }

  bool get showNextAndPrevButton{
    return _currentLessonIndex > 0;
  }

  bool gotoNextLesson(){
    print(_totalLessons);
    if(_currentLessonIndex<_totalLessons){
      _currentLessonIndex +=1;
      _completedLessons = _currentLessonIndex == _totalLessons;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool gotoPrevLesson(){
    if(_currentLessonIndex-1>0){
      _currentLessonIndex -=1;
      notifyListeners();
      return true;
    }
    return false;
  }

  Objective getSelectObjective(String objectString){
    return _currentTopic.objectives.firstWhere((objective) => objective.title.trim().toLowerCase() == objectString.toLowerCase());
  }
}