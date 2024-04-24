import 'package:database_project/Service/ErrorDto.dart';

class ApiException implements Exception {
  int statusCode;
  String error;
  String message;

  @override
  String toString(){
    return message;
  }

  ApiException({required this.statusCode , required this.message , required this.error});

  static ApiException makeException(ErrorDto errorDto){
    if(errorDto.error == "Unauthorized"){
      return UnauthorizedException.fromErrorDto(errorDto);
    }
    else if(errorDto.error == "Token Expired"){
      return TokenExpireException.fromErrorDto(errorDto);
    }
    else{
      return UnknownApiException.fromErrorDto(errorDto);
    }
  }
}

class UnauthorizedException extends ApiException{
  UnauthorizedException({required super.statusCode, required super.message, required super.error});

  factory UnauthorizedException.fromErrorDto(ErrorDto errorDto){
    return UnauthorizedException(statusCode: errorDto.statusCode , message: errorDto.message , error:  errorDto.error);
  }
}

class TokenExpireException extends ApiException{
  TokenExpireException({required super.statusCode, required super.message, required super.error});

  factory TokenExpireException.fromErrorDto(ErrorDto errorDto){
    return TokenExpireException(statusCode: errorDto.statusCode , message: errorDto.message , error:  errorDto.error);
  }
}

class UnknownApiException extends ApiException{
  UnknownApiException({required super.statusCode, required super.message, required super.error});

  factory UnknownApiException.fromErrorDto(ErrorDto errorDto){
    return UnknownApiException(statusCode: errorDto.statusCode , message: errorDto.message , error:  errorDto.error);
  }
}
