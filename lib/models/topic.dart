class Topic{
  final int id;
  final int subjId;
  final String topic;
  final String jw;
  final String createdAt;
  final String updatedAt;


  Topic(this.id,this.subjId,this.topic,this.jw,this.createdAt,this.updatedAt);

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        subjId = json['subj_id'],
        topic = json['topic'],
        jw = json['jw'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'subj_id': subjId,
    'topic':topic,
    'jw':jw,
    'created_at':createdAt,
    'updated_at':updatedAt
  };
}