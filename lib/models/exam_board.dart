
class ExamBoard{
  String name;
  num price;
  int subject_count;
  bool status;



  ExamBoard({required this.name,required this.price,required this.subject_count,required this.status});

  ExamBoard.fromJson(Map<String, dynamic> json):
    name = json['name'],
    price = json['price'],
    subject_count = json["subject_count"],
    status = json["status"];


  Map<String, dynamic> toJson() => {
    'name': name,
    'price':price,
    'subject_count':subject_count,
    'status':status
  };
}