
class Question {
  int id;
  int subjectId;
  int sourceId;
  int questionTypeId;
  String question;
  String questionDetails;
  String questionImage;
  String option1;
  String option2;
  String option3;
  String option4;
  String shortAnswer;
  String fullAnswer;
  String answerImage;
  String answerDetails;
  int questionYear;
  int questionYearNumber;
  String userSelectedOption;

  Question(this.id,this.subjectId,this.sourceId,this.questionTypeId,this.question,this.questionDetails,this.questionImage,this.option1,this.option2,this.option3,this.option4,this.shortAnswer,this.fullAnswer,this.answerImage,this.answerDetails,this.questionYear,this.questionYearNumber,{this.userSelectedOption=""});

  Question.fromJson(Map<String,dynamic> json):
      id = json["id"],
        subjectId = json["subject_id"],
        sourceId=json["source_id"],
        questionTypeId = json["question_type_id"],
        question = json["question"],
        questionDetails = json["question_details"],
        questionImage=json["question_image"],
        option1=json["option_1"],
        option2=json["option_2"],
        option3=json["option_3"],
        option4=json["option_4"],
        shortAnswer = json["short_answer"],
        fullAnswer= json["full_answer"],
        answerImage= json["answer_image"],
        answerDetails= json["answer_details"],
        questionYear=json["question_year"],
        userSelectedOption=json.containsKey("user_selected_option")?json["user_selected_option"]:"",
        questionYearNumber=json["question_year_number"];


  Map<String,dynamic> toJson() => {
    "id": id,
    "subject_id": subjectId,
    "source_id": sourceId,
    "question_type_id": questionTypeId,
    "question": question,
    "question_details": questionDetails,
    "question_image": questionImage,
    "option_1": option1,
    "option_2": option2,
    "option_3": option3,
    "option_4": option4,
    "short_answer": shortAnswer,
    "full_answer": fullAnswer,
    "answer_image": answerImage,
    "answer_details": answerDetails,
    "question_year": questionYear,
    "question_year_number": questionYearNumber,
    'user_selected_option':userSelectedOption
  };



}