import 'dart:convert';
import 'package:database_project/Model/User.dart';
import 'package:database_project/Model/User/CreateUserDto.dart';
import 'package:get/get.dart';
import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/Auth/JwtToken.dart';
import 'package:http/http.dart' as http;

import 'ApiService/Exception.dart';

class LoginService extends GetxService {
  String getLink(String path) {
    return "http://10.0.2.2:3000/$path";
  }

  String? accessToken;
  String? refreshToken;
  String? userId;
  String? password;
  List<Function> _onLogin = [];
  final List<Function> _onLogout = [];
  final RxBool _loggedIn = false.obs;
  bool get loggedIn => _loggedIn.value;

  static LoginService? _instance;
  static LoginService get instance => _instance ?? Get.find<LoginService>();

  static void init(){
    _instance = Get.put(LoginService());
  }

  static Future<ApiResponse<T>> tokenPipeline<T>({
    required Future<http.Response> Function() request ,
    required T Function(http.Response) action,
    Duration timeout = const Duration(seconds: 10)
  }) async{

    LoginService loginService = LoginService.instance;

    ApiResponse<T> response = await ApiResponse.handleRequest<T>(
        request: request(),
        action: action,
        timeout : timeout
    );

    StaticLogger.logger.i("[LoginService.tokenPipeline()] 1");

    if(response.exception is TokenExpireException){
      ApiResponse<bool> refreshTokenRes = await loginService.refreshAccessToken();
      if(!refreshTokenRes.isSuccess){
        StaticLogger.logger.i("[LoginService.tokenPipeline()] 2");

        loginService._setLogout();

        return ApiResponse.fromException(refreshTokenRes.exception!);
      }
      else{
        StaticLogger.logger.i("[LoginService.tokenPipeline()] 3");

        loginService._setLogin();

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



  Future<ApiResponse<bool>> login(String _userId, String _password) async {
    return await ApiResponse.handleRequest(
        request: http.post(
            Uri.parse(getLink("auth/login")),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"id": _userId, "password": _password})
        ).timeout(const Duration(seconds: 5)),

        action: (response) {
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

  void logout() async {
    userId = null;
    password = null;
    accessToken = null;

    _setLogout();

    for (var action in _onLogout) {
      action();
    }

    StaticLogger.logger.i("로그아웃 완료");
  }

  Future<ApiResponse<String>> signIn(CreateUserDto createUserDto) async {
    return await ApiResponse.handleRequest(
        request: http.post(
          Uri.parse(getLink("auth/sign-in")),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(createUserDto.toMap())
        ),
        action: (response) {
          return response.body;
        }
    );
  }


  Future<ApiResponse<bool>> refreshAccessToken() async {
    if (refreshToken == null) {
      return ApiResponse.fromException(Exception('Refresh Token이 없음.'));
    } else {
      StaticLogger.logger.i(refreshToken);
      return await ApiResponse.handleRequest(
          request: http.post(
            Uri.parse(getLink("auth/refresh")),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${refreshToken!}"
            },
          ).timeout(const Duration(seconds: 5)),

          action: (response) {
            JwtToken token = JwtToken.fromMap(jsonDecode(response.body));
            accessToken = token.accessToken;
            refreshToken = token.refreshToken;
            StaticLogger.logger.i("리프레쉬 성공 : ${refreshToken}");
            return true;
          }
      );
    }
  }

  void addOnLoginListener(Function action) {
    _onLogin.add(action);
  }

  void addOnLogoutListener(Function action) {
    _onLogout.add(action);
  }

  void _setLogin() {
    _loggedIn.value = true;
  }

  void _setLogout() {
    _loggedIn.value = false;
  }
}
