import 'dart:convert';
import 'package:database_project/Service/ApiService/Exception.dart';
import 'package:database_project/Service/ErrorDto.dart';
import 'package:logger/logger.dart';
import '../../Common/StaticLogger.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  Object? exception;
  StackTrace? stackTrace;
  bool isSuccess;
  Logger logger = Logger();

  T? response;

  ApiResponse({required this.isSuccess, this.exception, this.response , this.stackTrace});


  static Future<ApiResponse<T2>> handleRequest<T2>({
    required Future<http.Response> request,
    required T2 Function(http.Response) action,
    void Function(Object)? onError,
    Duration timeout = const Duration(seconds: 10)
  }) async {
    try {
      http.Response response = await request.timeout(timeout);

      if(200 <= response.statusCode && response.statusCode < 300){
        return ApiResponse(
          response:  action(response),
          isSuccess: true,
        );
      }
      else{
        throw ApiException.makeException(ErrorDto.fromMap(jsonDecode(response.body)));
      }
    } catch (e , stacktrace) {
      StaticLogger.logger.e('[ApiResponse.handleExceptions()] $e\n$stacktrace');
      if(onError != null){
        onError(e);
      }
      return ApiResponse(
          isSuccess: false,
          exception : e,
          stackTrace: stacktrace
      );
    }
  }

  factory ApiResponse.fromException(Object e){
    return ApiResponse(
      isSuccess: false,
      exception: e
    );
  }


  static Exception getNetworkException(int code){
    return Exception('Network Exception : $code');
  }


}