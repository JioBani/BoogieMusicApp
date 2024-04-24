// import 'dart:convert';
//
// import 'package:database_project/Common/StaticLogger.dart';
// import 'package:database_project/Service/ErrorDto.dart';
// import 'package:logger/logger.dart';
// import 'package:http/http.dart' as http;
//
// class ApiResponse<T> {
//   Object? exception;
//   StackTrace? stackTrace;
//   bool isSuccess;
//   Logger logger = Logger();
//
//   T? response;
//
//   ApiResponse({required this.isSuccess, this.exception, this.response , this.stackTrace});
//
//
//   static Future<ApiResponse<T2>> handleRequest<T2>({
//     required Future<http.Response> request,
//     required T2 Function(http.Response) action,
//   }) async {
//     try {
//       http.Response response = await request;
//
//       if(response.statusCode != 200 && response.statusCode != 201){
//         StaticLogger.logger.e(response.body);
//         throw ApiException.makeException(ErrorDto.fromMap(jsonDecode(response.body)));
//       }
//       else{
//         return ApiResponse(
//           response:  action(response),
//           isSuccess: true,
//         );
//       }
//     } catch (e , stacktrace) {
//       StaticLogger.logger.e('[RiotApiResponse.handleExceptions()] $e\n$stacktrace');
//       return ApiResponse(
//           isSuccess: false,
//           exception : e,
//           stackTrace: stacktrace
//       );
//     }
//   }
//
//   factory ApiResponse.fromException(Object e){
//     return ApiResponse(
//         isSuccess: false,
//         exception: e
//     );
//   }
//
//   factory ApiResponse.fromSuccess(T response){
//     return ApiResponse(
//         isSuccess: true,
//         response: response
//     );
//   }
// }
//
