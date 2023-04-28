
import 'package:prep50/models/question.dart';

class WeeklyQuiz{
  String id;
  int prize;
  String message;
  int duration;
  String startTime;
  int week;
  int session;
  bool started;
  List<Question> questions;

  WeeklyQuiz(this.id,this.prize,this.message,this.duration,this.startTime,this.week,this.session,this.started,this.questions);

  WeeklyQuiz.fromJson(Map<String,dynamic> json) :
      id=json["id"],
      prize = json["prize"],
      message=json["message"],
      duration = json["duration"],
      startTime = json["start_time"],
      week = json["week"],
      session = json["session"],
      started = json["started"],
      questions = json["questions"].map<Question>((questionJson) => Question.fromJson(questionJson)).toList();

}