import 'dart:convert';
import 'dart:typed_data';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/model/auth_response.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/home/model/comments/create_comments_model.dart';
import 'package:music_app/ui/views/home/model/comments/get_comments_model.dart';
import 'package:music_app/ui/views/home/model/post/create_post_model.dart';
import 'package:music_app/ui/views/home/model/post/post_download_media_model.dart';
import 'package:music_app/ui/views/home/model/post/post_model.dart';
import 'package:music_app/ui/views/home/model/post/post_update_model.dart';
import 'package:music_app/ui/views/home/model/reactions/create_reactions_model.dart';
import 'package:music_app/ui/views/home/model/reactions/get_reactions_model.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';

class ApiService {
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
    safePrint('Log in user endpoint : \n $endpoint');
    safePrint('Log in user data: \n $data');
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(
          contentType: 'application/x-amz-json-1.1',
        ),
      );
      safePrint('Logged in user response: ${response.data}');
      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("AuthenticationResult")) {
        return AuthResponse.fromJson(decodedData);
      }
      safePrint("Logged in user response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Login Failed: ${e.response?.data}');
      } else {
        safePrint('Login Failed Unexpected error: $e');
      }
      return null;
    }
  }

//MARK: Signup API
  Future<SignUpModel?> signupWithDio({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    safePrint('Signup user endpoint : \n $endpoint');
    safePrint('Signup user data: \n $data');
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      safePrint('Signup user response: ${response.data}');
      // If Dio gives a string, decode it
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("message")) {
        return SignUpModel.fromJson(decodedData);
      }
      safePrint("Signup user response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Signup Failed: ${e.response?.data}');
      } else {
        safePrint('Signup Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: Get User Info API
  Future<UpdatedAttributes?> getUserInfo({required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint('Logged in user profile api endpoint : \n $endpoint');
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      safePrint(
          'Logged in user profile api response: ${response.data['users']}');
      String decrypted = await decryptData(response.data['users']);
      final Map<String, dynamic> decodedJson = json.decode(decrypted);
      // If Dio gives a string, decode it
      if (decodedJson['users'] != null && decodedJson['users'] is List) {
        final List<dynamic> usersList = decodedJson['users'];
        if (usersList.isNotEmpty) {
          // Parse the first user from the list
          final userJson = usersList[0];
          safePrint("Get Profile API response structure: $userJson");
          return UpdatedAttributes.fromJson(userJson);
        } else {
          throw Exception("User list is empty");
        }
      } else {
        throw Exception(
            "Invalid JSON structure: 'users' key missing or not a list");
      }
    } catch (e) {
      if (e is DioException) {
        safePrint('Get Profile API Error: ${e.response?.data}');
      } else {
        safePrint('Get Profile API Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: User update Info API
  Future<UpdatedAttributes?> updateUserInfo({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint('Profile update api endpoint : \n $endpoint');
    safePrint('Profile update api data : \n $data');
    try {
      final response = await _dio.patch(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      safePrint('Profile Update api response: ${response.data['users']}');
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      safePrint("Profile update $decodedData");
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("message")) {
        return UpdatedAttributes.fromJson(decodedData);
      }
      safePrint("Profile Update api response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Profile Update api failed: ${e.response?.data}');
      } else {
        safePrint('Profile Update api Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: Create Post API
  Future<CreatePostModel?> createPostAPI({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Create Post API $endpoint");
    safePrint("Create Post API $data");

    try {
      final response = await dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CreatePostModel.fromJson(response.data);
      } else {
        debugPrint(
            'Create Post API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Create Post API Error fetching post: $e');
      return null;
    }
  }

  //MARK: Post update  API
  Future<PostUpdateModel?> updatePostAPI({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    safePrint('Post Update api endpoint : \n $endpoint');
    safePrint('Post Update api data : \n $data');
    try {
      final response = await _dio.patch(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      safePrint('Post Update api response: ${response.data['users']}');
      final decodedData =
          response.data is String ? jsonDecode(response.data) : response.data;
      safePrint("Post Update $decodedData");
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey("message")) {
        return PostUpdateModel.fromJson(decodedData);
      }
      safePrint("Post Update api response structure: $decodedData");
      return null;
    } catch (e) {
      if (e is DioException) {
        safePrint('Post Update api failed: ${e.response?.data}');
      } else {
        safePrint('Post Update api Unexpected error: $e');
      }
      return null;
    }
  }

  //MARK: Home Post API
  Future<PostModel?> homePost({required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Home Post API $endpoint");
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
        return PostModel.fromJson(response.data);
      } else {
        debugPrint(
            'Home Post API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Home Post API Error fetching post: $e');
      return null;
    }
  }

  //MARK:  Home Post Image download API
  Future<PostDownloadMediaModel?> postImageDownloadAPI(
      {required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Home Post Image download API $endpoint");
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
        return PostDownloadMediaModel.fromJson(response.data);
      } else {
        debugPrint(
            'Home Post Image download API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Home Post Image download API Error fetching post: $e');
      return null;
    }
  }

//MARK: Get Comments list api
  Future<GetCommentsModel?> commentsListAPI({required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Comment List API $endpoint");
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
      safePrint("Comment List response ${response.data}");

      if (response.data != null) {
        return GetCommentsModel.fromJson(response.data);
      } else {
        debugPrint(
            'Comment List  API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Comment List API Error fetching post: $e');
      return null;
    }
  }

//MARK: Create Comments api
  Future<CreateCommentsModel?> createCommentsAPI({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Comment List API $endpoint");
    safePrint("Comment List API $data");

    try {
      final response = await dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      safePrint("Create Comments response ${response.data}");

      if (response.data != null) {
        return CreateCommentsModel.fromJson(response.data);
      } else {
        debugPrint(
            'Create Comments API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Create Comments API Error fetching post: $e');
      return null;
    }
  }

  //MARK: Create Reactions api
  Future<CreateReactionsModel?> createReactionsAPI({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Reactions API $endpoint");
    safePrint("Reactions API $data");
    safePrint("Reactions API $token");

    try {
      final response = await dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      safePrint("Create Reactions response ${response.data}");

      if (response.statusCode == 200) {
        return CreateReactionsModel.fromJson(response.data);
      } else {
        debugPrint(
            'Create Reactions API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Create Reactions API Error fetching post: $e');
      return null;
    }
  }

//MARK: Get Reactions list api
  Future<GetReactionsModel?> reactionsListAPI(
      {required String endpoint}) async {
    final token = await SharedPreferencesHelper.getAccessToken(ksAccessToekn);
    final dio = Dio();
    safePrint("Reactions List API $endpoint");
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
      safePrint("Reactions List response ${response.data}");

      if (response.data != null) {
        return GetReactionsModel.fromJson(response.data);
      } else {
        debugPrint(
            'Reactions List  API Failed: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Reactions List API Error fetching post: $e');
      return null;
    }
  }

  //MARK: Logged in user profile decrytion method
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
