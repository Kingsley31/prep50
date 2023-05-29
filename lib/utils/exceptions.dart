
class ValidationException implements Exception{
  String message;
  List<String> errors;

  ValidationException({required this.message,required this.errors});


}

class WeeklyQuizException implements Exception{
  String message;
  WeeklyQuizException({required this.message});
}

class LoginException implements Exception{
  String message;
  LoginException({required this.message});
}