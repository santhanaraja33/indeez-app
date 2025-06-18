import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/model/auth_response.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';

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

//MARK: Login API
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
      safePrint('Raw Response: ${response.data}');
      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("AuthenticationResult")) {
        return AuthResponse.fromJson(decodedData);
      }
      safePrint("Unexpected response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Login Failed: ${e.response?.data}');
      } else {
        safePrint('Unexpected error: $e');
      }
      return null;
    }
  }

//MARK: Signup API
  Future<SignUpModel?> signupWithDio({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = SharedPreferencesHelper.getAccessToken(ksAccessToekn);

    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      safePrint('Raw Response: ${response.data}');
      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("message")) {
        return SignUpModel.fromJson(decodedData);
      }
      safePrint("Unexpected response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Login Failed: ${e.response?.data}');
      } else {
        safePrint('Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: Get User Info API
  Future<UserprofileModel?> getUserInfo({required String endpoint}) async {
    final token = SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint(endpoint);
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      safePrint('Raw Response: ${response}');
      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("message")) {
        return UserprofileModel.fromJson(decodedData);
      }
      safePrint("Unexpected response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Login Failed: ${e.response?.data}');
      } else {
        safePrint('Unexpected error: $e');
      }
      return null;
    }
  }
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
