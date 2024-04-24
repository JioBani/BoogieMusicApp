class JwtToken{
  String accessToken;
  String refreshToken;

  JwtToken({required this.accessToken , required this.refreshToken});

  factory JwtToken.fromMap(Map<String , dynamic> map){
    return JwtToken(accessToken: map['accessToken'], refreshToken: map['refreshToken']);
  }
}