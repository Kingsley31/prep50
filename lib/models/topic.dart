import 'package:prep50/models/objective.dart';

class Topic{
  final int id;
  final int subjectId;
  final String title;
  final String details;
  final List<Objective> objectives;



  Topic(this.id,this.subjectId,this.title,this.details,this.objectives);

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        subjectId = json['subject_id'],
        title = json['title'],
        details = json['details'],
        objectives = json.containsKey('objectives') ? json['objectives'].map<Objective>((objective) => Objective.fromJson(objective)).toList():[];

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_id': subjectId,
    'title':title,
    'details':details,
    'objectives':objectives.map<Map<String,dynamic>>((objective) => objective.toJson()).toList()
  };
}