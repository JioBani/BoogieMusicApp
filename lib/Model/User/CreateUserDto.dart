import 'package:database_project/Common/StaticLogger.dart';

class CreateUserDto{
    String id;
    String name;
    String password;

    CreateUserDto({required this.id, required this.name, required this.password});

    Map<String , dynamic> toMap(){
      return {
        "user_id" : id,
        "user_name" : name,
        "user_pw" : password,
      };
    }

    (bool , String) checkValidate(){
      if(id.length < 8){
        StaticLogger.logger.i(id.length);
        return (false , "아이디는 8자리 이상이어야 합니다.");
      }

      if(!_isValidUserId(id)){
        return (false , "아이디에는 대소문자 영문과 숫자만 사용 할 수 있습니다.");
      }

      if(name.length < 2){
        return (false , "이름은 2자리 이상이어야 합니다.");
      }

      if(!_isValidName(name)){
        return (false , "이름에는 대소문자 영문 , 한글과 - 만 사용 할 수 있습니다.");
      }

      if(password.length < 8){
        return (false , "비밀번호는 8자리 이상이어야 합니다.");
      }

      if(!_isValidPassword(password)){
        return (false , "비밀번호는 대소문자 영문, 숫자, 특수문자 !@#\$%~_- 만 사용 할 수 있습니다.");
      }

      return (true , "");
    }

    bool _isValidUserId(String username) {
      return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username);
    }

    bool _isValidPassword(String password) {
      return RegExp(r'^[a-zA-Z0-9!@#\$%]+$').hasMatch(password);
    }

    bool _isValidName(String name) {
      return RegExp(r'^[a-zA-Z\uAC00-\uD7AF\s\-]+$').hasMatch(name);
    }


}