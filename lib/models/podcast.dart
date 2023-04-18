


class Podcast{
  String id;
  int subjectId;
  int? topicId;
  String title;
  String url;
  String createdAt;
  String updateAt;

  Podcast({
    required this.id,
    required this.subjectId,
    this.topicId,
    required this.title,
    required this.url,
    required this.createdAt,
    required this.updateAt
  });

  Podcast.fromJson(Map<String,dynamic> json):
        id= json["id"],
        subjectId = json["subject_id"],
        topicId = json.containsKey("topic_id")?json["topic_id"]:null,
        title = json["title"],
        url = json["url"],
        createdAt = json["created_at"],
        updateAt = json["update_at"];


  Map<String, dynamic> toJson() => {
    'id':id,
    'subject_id':subjectId,
    'topic_id':topicId,
    'title':title,
    'url':url,
    'created_at':createdAt,
    'update_at':updateAt
  };
}