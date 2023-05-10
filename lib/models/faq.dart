
class Faq{
  String title;
  String slug;
  String content;

  Faq(this.slug,this.title,this.content);

  Faq.fromJson(Map<String,dynamic> json):
      title=json["title"],
      slug=json["slug"],
      content=json["content"];

  toJson()=>{
    "title":title,
    "slug":slug,
    "content":content
  };


}