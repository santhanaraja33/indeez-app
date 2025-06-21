import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/model/auth_response.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/post_model.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';

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
        safePrint('Signup Failed: ${e.response?.data}');
      } else {
        safePrint('Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: Get User Info API
  Future<UserprofileModel?> getUserInfo({required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint(endpoint);
    safePrint(token);

    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      safePrint('Raw Response: ${response.data['users']}');

      decryptData(response.data['users']);

      // ✅ passing only the base64-encoded string

      // If Dio gives a string, decode it
      // final decodedData =
      //     response.data is String ? jsonDecode(response.data) : response.data;
      // if (decodedData is Map<String, dynamic> &&
      //     decodedData.containsKey("users")) {
      //   return UserprofileModel.fromJson(decodedData);
      // }
      // safePrint("Unexpected response structure: $decodedData");
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

  //MARK: User update Info API
  Future<UserUpdateprofileModel?> updateUserInfo({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint(endpoint);
    safePrint(data);

    try {
      final response = await _dio.patch(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("updatedAttributes")) {
        return UserUpdateprofileModel.fromJson(decodedData);
      }
      safePrint("profile update structure: $decodedData['users']");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('profile update failed: ${e.response?.data}');
      } else {
        safePrint('Unexpected error: $e');
      }
      return null;
    }
  }

// Home Post API
  Future<Post?> homePost({
    required String endpoint,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();

    try {
      final response = await dio.get(
        endpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        debugPrint(
            'Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching post: $e');
      return null;
    }
  }

  Future<String> decryptData(String encryptedBase64) async {
    //  hex key is the key used for decryption, store it in env variable
    const hexKey =
        "c738562fe9cd5e307c264543f3e518ead8c115c28dcad62c3f7f07f259d737d1";

    try {
      // Convert hex key string to bytes
      final key = Uint8List.fromList(_hexToBytes(hexKey));
      final iv = Uint8List.fromList(
          _hexToBytes(hexKey.substring(0, 32))); // 16 bytes IV

      // Decode base64 ciphertext
      final encryptedBytes = base64.decode(encryptedBase64);

      // Setup AES CBC decryption
      final cipher = CBCBlockCipher(AESFastEngine())
        ..init(
            false, ParametersWithIV(KeyParameter(key), iv)); // false = decrypt

      // Decrypt
      final decryptedPadded = _processBlocks(cipher, encryptedBytes);
      safePrint(decryptedPadded);
      safePrint(_removePkcs7Padding(decryptedPadded));

      // Remove PKCS7 padding
      return _removePkcs7Padding(decryptedPadded);
    } catch (e) {
      throw Exception("Decryption failed: $e");
    }
  }

  Uint8List _processBlocks(BlockCipher cipher, Uint8List input) {
    final output = Uint8List(input.length);
    for (int offset = 0; offset < input.length;) {
      offset += cipher.processBlock(input, offset, output, offset);
    }
    return output;
  }

  String _removePkcs7Padding(Uint8List data) {
    final pad = data.last;
    return utf8.decode(data.sublist(0, data.length - pad));
  }

  List<int> _hexToBytes(String hex) {
    final result = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      final byte = hex.substring(i, i + 2);
      result.add(int.parse(byte, radix: 16));
    }
    return result;
  }
}

extension on Map<String, dynamic> {
  String substring(int i, int j) {
    throw UnimplementedError(
        'substring is not implemented for Map<String, dynamic>');
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
