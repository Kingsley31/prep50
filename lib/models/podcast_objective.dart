
import 'package:prep50/models/podcast.dart';

class PodcastObjective{
  int id;
  int subjectId;
  String title;
  String details;
  List<Podcast> podcasts;
  int progress;


  PodcastObjective({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.details,
    required this.podcasts,
    required this.progress
  });

  PodcastObjective.fromJson(Map<String,dynamic> json):
        id = json["id"],
        subjectId = json["subject_id"],
        title = json["title"],
        details = json["details"],
        progress=json["progress"],
        podcasts =json.containsKey("podcasts")? json["podcasts"].map<Podcast>((podcastJson) => Podcast.fromJson(podcastJson)).toList():[];


  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_id':subjectId,
    'title':title,
    'details':details,
    'podcasts':podcasts.map<Map<String,dynamic>>((podcast) => podcast.toJson()).toList(),
    'progress':progress,
  };


}