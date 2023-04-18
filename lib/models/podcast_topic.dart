
import 'package:prep50/models/podcast.dart';
import 'package:prep50/models/podcast_objective.dart';

class PodcastTopic{
  final int id;
  final int subjectId;
  final String title;
  final String details;
  List<Podcast> podcasts;



  PodcastTopic(this.id,this.subjectId,this.title,this.details,this.podcasts);

  PodcastTopic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        subjectId = json['subject_id'],
        title = json['title'],
        details = json['details'],
        podcasts = json.containsKey('podcasts') ? json['podcasts'].map<Podcast>((podcast) => Podcast.fromJson(podcast)).toList():[];

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_id': subjectId,
    'title':title,
    'details':details,
    'podcasts':podcasts.map<Map<String,dynamic>>((podcast) => podcast.toJson()).toList()
  };
}