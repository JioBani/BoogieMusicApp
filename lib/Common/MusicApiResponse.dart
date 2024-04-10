import 'package:logger/logger.dart';
import 'StaticLogger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicApiResponse<T> {
  Object? exception;
  StackTrace? stackTrace;
  bool isSuccess;
  Logger logger = Logger();

  T? response;

  MusicApiResponse({required this.isSuccess, this.exception, this.response , this.stackTrace});


  static Future<MusicApiResponse<T2>> handleExceptions<T2>(Future<T2> Function() asyncFunction) async {
    try {
      return MusicApiResponse(
          response:  await asyncFunction(),
          isSuccess: true,
      );
    } catch (e , stacktrace) {
      StaticLogger.logger.e('[RiotApiResponse.handleExceptions()] $stacktrace : $e : ${e.runtimeType}');
      return MusicApiResponse(
          isSuccess: false,
          exception : e,
          stackTrace: stacktrace
      );
    }
  }

  static Future<MusicApiResponse<T2>> handleRequest<T2>({
      required Future<http.Response> request,
      required T2 Function(http.Response) action
  }) async {
    try {
      http.Response response = await request;

      if(response.statusCode != 200 && response.statusCode != 201){
        throw getNetworkException(response.statusCode);
      }
      else{
        return MusicApiResponse(
          response:  action(response),
          isSuccess: true,
        );
      }
    } catch (e , stacktrace) {
      StaticLogger.logger.e('[RiotApiResponse.handleExceptions()] $stacktrace : $e : ${e.runtimeType}');
      return MusicApiResponse(
          isSuccess: false,
          exception : e,
          stackTrace: stacktrace
      );
    }
  }


  static Exception getNetworkException(int code){
    return Exception('Network Exception : $code');
  }


}