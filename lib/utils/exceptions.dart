
class ValidationException implements Exception{
  String message;
  List<String> errors;

  ValidationException({required this.message,required this.errors});


}