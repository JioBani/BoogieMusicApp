class ErrorDto{
  String message;
  String error;
  int statusCode;

  ErrorDto({required this.message, required this.error, required this.statusCode});

  factory ErrorDto.fromMap(Map<String,dynamic> map){
    return ErrorDto(message: map['message'], error:  map['error'], statusCode:  map['statusCode']);
  }
}