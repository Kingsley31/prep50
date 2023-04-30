
class NewsFeedListItem{
  String slug;
  String title;
  String photo;
  String content;
  String createdAt;
  String updatedAt;
  int likes;
  int comments;
  bool isLiked;
  bool isBookmarked;

  NewsFeedListItem(this.slug,this.title,this.photo,this.content,this.createdAt,this.updatedAt,this.likes,this.comments,this.isLiked,this.isBookmarked);

  NewsFeedListItem.fromJson(Map<String,dynamic> json):
      slug=json["slug"],
      title = json["title"],
      photo=json["photo"],
      content=json["content"],
      createdAt=json["created_at"],
      updatedAt=json["updated_at"],
      likes=json["likes"],
      comments=json["comments"],
      isLiked=json["is_liked"],
      isBookmarked=json["is_bookmarked"];

  toJson() => {
    "slug":slug,
    "title":title,
    "photo":photo,
    "content":content,
    "created_at":createdAt,
    "updated_at":updatedAt,
    "likes":likes,
    "comments":comments,
    "is_liked":isLiked,
    "is_bookmarked":isBookmarked
  };

}