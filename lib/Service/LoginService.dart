import 'dart:convert';

import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/Auth/JwtToken.dart';
import 'package:http/http.dart' as http;

import 'ApiService/Exception.dart';


//TODO getxservice로 변경

class LoginService{
  static String getLink(String path){
    return "http://10.0.2.2:3000/$path";
  }

  static String? accessToken;
  static String? refreshToken;
  static String? userId;
  static String? password;
  static final  List<Function> _onLogin = [];
  static final List<Function> _onLogout = [];
  static bool _loggedIn = false;
  static bool get loggedIn => _loggedIn;

  static Future<ApiResponse<bool>> login(String _userId, String _password) async {
    return await ApiResponse.handleRequest(
        request: http.post(
            Uri.parse(getLink("auth/login")),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "id" : _userId,
              "password" : _password
            })
        ).timeout(const Duration(seconds: 5)),

        action: (response){
          JwtToken token = JwtToken.fromMap(jsonDecode(response.body));
          accessToken = token.accessToken;
          refreshToken = token.refreshToken;
          userId = _userId;
          password = _password;

          _setLogin();

          for (var action in _onLogin) {
            action();
          }
          return true;
        },
        onError: (e) => _setLogout()
    );
  }

  static void logout() async {
    userId = null;
    password = null;
    accessToken = null;

    _setLogout();

    for (var action in _onLogout) {
      action();
    }

    StaticLogger.logger.i("로그아웃 완료");
  }

  // static Future<ApiResponse<bool>?> auth() async {
  //   if(accessToken == null){
  //     _setLogout();
  //     return null;
  //   }
  //   else{
  //     return await ApiResponse.handleRequest(
  //         request: http.get(
  //             Uri.parse(getLink("auth/authenticate")),
  //             headers: {
  //               "Content-Type": "application/json",
  //               "Authorization" : "Bearer ${accessToken!}"
  //             },
  //         ).timeout(const Duration(seconds: 5)),
  //
  //         action: (response){
  //           _loggedIn = true;
  //           return true;
  //         },
  //         onError: (e)=>_loggedIn = false
  //     );
  //   }
  // }

  static Future<ApiResponse<bool>> refreshAccessToken() async {
    if(refreshToken == null){
      return ApiResponse.fromException(Exception('Refresh Token이 없음.'));
    }
    else{
      StaticLogger.logger.i(refreshToken);
      return await ApiResponse.handleRequest(
          request: http.post(
            Uri.parse(getLink("auth/refresh")),
            headers: {
              "Content-Type": "application/json",
              "Authorization" : "Bearer ${refreshToken!}"
            },
          ).timeout(const Duration(seconds: 5)),

          action: (response){
            JwtToken token = JwtToken.fromMap(jsonDecode(response.body));
            accessToken = token.accessToken;
            refreshToken = token.refreshToken;
            StaticLogger.logger.i("리프레쉬 성공 : ${refreshToken}");
            return true;
          }
      );
    }
  }

  static Future<ApiResponse<T>> tokenPipeline<T>({
      required Future<http.Response> Function() request ,
      required T Function(http.Response) action,
      Duration timeout = const Duration(seconds: 10)
    }) async{

    ApiResponse<T> response = await ApiResponse.handleRequest<T>(
        request: request(),
        action: action,
        timeout : timeout
    );

    StaticLogger.logger.i("[LoginService.tokenPipeline()] 1");

    if(response.exception is TokenExpireException){
      ApiResponse<bool> refreshTokenRes = await LoginService.refreshAccessToken();
      if(!refreshTokenRes.isSuccess){
        StaticLogger.logger.i("[LoginService.tokenPipeline()] 2");

        _setLogout();

        return ApiResponse.fromException(refreshTokenRes.exception!);
      }
      else{
        StaticLogger.logger.i("[LoginService.tokenPipeline()] 3");

        _setLogin();

        return await ApiResponse.handleRequest<T>(
            request: request(),
            action: action
        );
      }
    }
    else{
      StaticLogger.logger.i("[LoginService.tokenPipeline()] 4");
      return response;
    }
  }


  static void addOnLoginListener(Function action){
    _onLogin.add(action);
  }

  static void addOnLogoutListener(Function action){
    _onLogout.add(action);
  }
  static void _setLogin(){
    _loggedIn = true;
  }

  static void _setLogout(){
    _loggedIn = false;
  }



}