import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/model/auth_response.dart';

class ApiService {
  // ignore: non_constant_identifier_names
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.loginAWSUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth',
    },
  ));

  Future<AuthResponse?> loginWithDio({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(
          contentType: 'application/x-amz-json-1.1',
        ),
      );

      print('Raw Response: ${response.data}');

      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("AuthenticationResult")) {
        return AuthResponse.fromJson(decodedData);
      }

      print("Unexpected response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        print('Login Failed: ${e.response?.data}');
      } else {
        print('Unexpected error: $e');
      }
      return null;
    }
  }

  // static Future<Response> post(String endpoint, dynamic data) async {
  //   try {
  //     final response = await _dio.post(endpoint, data: data);
  //     return response;
  //   } on DioException catch (e) {
  //     print('⚠️ DioException caught!');
  //     print('➡️ Error Type: ${e.type}');
  //     print('➡️ Message: ${e.message}');
  //     print('➡️ Response: ${e.response?.data}');
  //     print('➡️ Status Code: ${e.response?.statusCode}');
  //     throw Exception('API Error: ${e.response?.data ?? e.message}');
  //   }
  // }
}

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // DioException( );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiConstants.loginAWSUrl;
    //BaseOptions(baseUrl: "");
    // const token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0b21lcklkIjoiNjYzYTBhODVhNzJmNDQxOWMzODFiMDJjIiwiZGV2aWNlIjoiNjYzYTBhODVhNzJmNDQxOWMzODFiMDQ3IiwiZXhwIjo3MzcxNjUzMDk1MSwiaWF0IjoxNzE2NTMwOTUxfQ.HdMJiAjr3yPebJGy2tSsWgEgVm0oKfrsrUmORPEudDE";
    // options.headers = {
    //   "Authorization": "Bearer $token",
    //   "Content-Type": "application/json",
    //   'device':
    //       '{"device":"Nexus Phone","app":"web","device_type":2,"os":"unknown","ip_address":"103.28.246.86","browser":"Chrome"}',
    // };
    debugPrint("DioInterceptor Request");
    //debugPrint(token);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("DioInterceptor response");
    debugPrint(response.toString());

    //response = Response(requestOptions: RequestOptions());
    super.onResponse(response, handler);
  }
}
