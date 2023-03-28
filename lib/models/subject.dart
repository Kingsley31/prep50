import 'package:prep50/models/topic.dart';

class Subject{
  final int id;
  final String name;
  final List<Topic> topics;


  Subject(this.id,this.name,this.topics);

  Subject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
       topics=json['topics'] !=null ? json['topics'].
       map<Topic>((jsonTopic) => Topic(jsonTopic["id"],jsonTopic["subj_id"],jsonTopic["topic"],jsonTopic["jw"],jsonTopic["created_at"],jsonTopic["updated_at"])).toList():[];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'topics':topics
  };
}