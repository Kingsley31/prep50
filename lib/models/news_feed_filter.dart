
class NewsFeedFilter{
  int trending;
  int newest;
  int oldest;

  NewsFeedFilter(this.trending,this.newest,this.oldest);

  NewsFeedFilter.fromJson(Map<String,dynamic> json):
      trending=json["trending"],
      newest=json["newest"],
      oldest=json["oldest"];

  Map<String,dynamic> toJson() => {
    "trending":trending,
    "newest":newest,
    "oldest":oldest
  };

}