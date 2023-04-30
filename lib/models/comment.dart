class Comment {
  String id;
  String comment;
  String createdAt;
  String username;

  Comment(this.id, this.comment, this.createdAt, this.username);

  Comment.fromJson(Map<String, dynamic> json):
    id = json['id'],
    comment = json['comment'],
    createdAt = json['created_at'],
    username = json['username'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['Username'] = this.username;
    return data;
  }
}