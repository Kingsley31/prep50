
import 'package:prep50/models/comment.dart';

class NewsFeed{
  String slug;
  String title;
  String photo;
  String content;
  String createdAt;
  String updatedAt;
  int likes;
  bool isLiked;
  bool isBookmarked;
  List<Comment> comments;

  NewsFeed(
        this.slug,
        this.title,
        this.photo,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.likes,
        this.isLiked,
        this.isBookmarked,
        this.comments);

  NewsFeed.fromJson(Map<String, dynamic> json):
    slug = json['slug'],
    title = json['title'],
    photo = json['photo']??"",
    content = json['content'],
    createdAt = json['created_at'],
    updatedAt = json['updated_at'],
    likes = json['likes'],
    isLiked = json['is_liked'],
    isBookmarked = json['is_bookmarked'],
    comments= json["comments"].map<Comment>((commentJson) => Comment.fromJson(commentJson)).toList();


  Map<String, dynamic> toJson() => {
    "slug":slug,
    "title":title,
    "photo":photo,
    "content":content,
    "created_at":createdAt,
    "updated_at":updatedAt,
    "likes":likes,
    "is_liked":isLiked,
    "is_bookmarked" :  isBookmarked,
    "comments":comments.map<Map<String,dynamic>>((v) => v.toJson()).toList()

  };
}