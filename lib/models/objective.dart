


import 'package:prep50/models/lesson.dart';

class Objective{
  int id;
  int? topicId;
  int? objectiveId;
  String title;
  String details;
  List<Lesson> lessons;
  int progress;


  Objective({
    required this.id,
    this.topicId,
    this.objectiveId,
    required this.title,
    required this.details,
    required this.lessons,
    required this.progress
  });

  Objective.fromJson(Map<String,dynamic> json):
        id = json["id"],
        topicId = json.containsKey("topic_id")?json["topic_id"]:null,
        objectiveId = json.containsKey("objective_id") ? json["objective_id"]:null,
        title = json["title"],
        details = json["details"],
        progress=json["progress"],
        lessons = json.containsKey('lessons') ? json["lessons"].map<Lesson>((lessonJson) => Lesson.fromJson(lessonJson)).toList():[];


  Map<String, dynamic> toJson() => {
    'id': id,
    'topic_id':topicId,
    'objective_id':objectiveId,
    'title':title,
    'details':details,
    'lessons':lessons.map<Map<String,dynamic>>((lesson) => lesson.toJson()).toList(),
    'progress':progress,
  };

  bool operator ==(dynamic other) =>
      other != null && other is Objective && this.objectiveId == other.objectiveId;

  @override
  int get hashCode => super.hashCode;
}