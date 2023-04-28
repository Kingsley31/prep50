
class WeeklyQuizParticipant{
  String username;
  String email;
  String photo;
  int score;

  WeeklyQuizParticipant(this.username,this.email,this.photo,this.score);

  WeeklyQuizParticipant.fromJson(Map<String,dynamic> json):
      username=json["username"],
      email=json["email"],
      photo = json["photo"],
      score=json["score"];
}