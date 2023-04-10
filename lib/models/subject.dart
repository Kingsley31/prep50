import 'package:prep50/models/topic.dart';

class Subject{
  final int id;
  final String name;
  final List<Topic> topics;
  final int progress;


  Subject(this.id,this.name,this.topics,this.progress);

  Subject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        progress = json["progress"],
       topics=json.containsKey('topics') ? json['topics'].
       map<Topic>((jsonTopic) => Topic.fromJson(jsonTopic)).toList():[];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'topics':topics.map<Map<String,dynamic>>((topic) => topic.toJson()).toList(),
    'progress':progress
  };
}