

class Lesson{
  int id;
  int subjectId;
  int? objectiveId;
  String title;
  String content;
  String videoUrl;
  String slideUrl;
  String docsUrl;
  String createdAt;
  String updateAt;

  Lesson({
    required this.id,
    required this.subjectId,
    this.objectiveId,
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.slideUrl,
    required this.docsUrl,
    required this.createdAt,
    required this.updateAt
  });

  Lesson.fromJson(Map<String,dynamic> json):
      id = json["id"],
      subjectId = json["subject_id"],
      objectiveId = json.containsKey("objective_id")?json["objective_id"]:null,
      title = json["title"],
      content = json["content"],
      videoUrl = json["video_url"],
      slideUrl = json["slide_url"],
      docsUrl = json["docs_url"],
      createdAt = json["created_at"],
      updateAt = json["update_at"];


  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_id':subjectId,
    'objective_id':objectiveId,
    'title':title,
    'content':content,
    'video_url':videoUrl,
    'slide_url':slideUrl,
    'docs_url':docsUrl,
    'created_at':createdAt,
    'update_at':updateAt
  };
}