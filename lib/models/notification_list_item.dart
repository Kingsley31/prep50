

class NotificationListItem{
  String id;
  String title;
  String body;
  String imageUrl;
  String createdAt;
  bool user;

  NotificationListItem(this.id,this.title,this.body,this.imageUrl,this.createdAt,this.user);


  NotificationListItem.fromJson(Map<String,dynamic> json):
      id=json["id"],
      title=json["title"],
      body=json["body"],
      imageUrl=json["image_url"],
      createdAt=json["created_at"],
      user=json["user"];

  toJson() => {
    "id":this.id,
    "title":this.title,
    "body":this.body,
    "image_url":this.imageUrl,
    "created_at":this.createdAt,
    "user":this.user
  };
}