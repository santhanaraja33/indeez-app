import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/api/api_constants.dart';

import 'api_exception.dart';

class ApiServices {
  late Dio dio;
  late BaseOptions baseOptions;
  // Map<String, dynamic> deviceInfoHeader = DeviceDetails().deviceDetailsInfo;
  ApiServices() {
    baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        //   "Authorization": "Bearer $token",
        //   "Content-Type": "application/json",

        //deviceinfo_pluse package
        /*
        {"device":"Redmi Note 9 Pro","app":"mobile","appType":"android","device_type":2,"os":"android","osVersion":"12","browser":"null","browserVersion":"null"}
        */
        'device':
            '{"device":"Nexus Phone","app":"web","device_type":2,"os":"unknown","ip_address":"103.28.246.86","browser":"Chrome"}',
      }, //..addAll(deviceInfoHeader),
    );
    dio = Dio(baseOptions);
    dio.interceptors.add(DioInterceptor());
    debugPrint("ApiDioClient initialise");
  }

  // Map<String, dynamic> getDeviceDetails() {
  //   return DeviceDetails().deviceDetailsInfo;
  // }

  Future<Response> post(String path,
      {Map<String, String> headers = const {}, Map body = const {}}) async {
    var options = Options();
    options.headers = headers;

    debugPrint("API post");
    debugPrint(path);
    debugPrint(body.toString());

    try {
      var response = await dio.post(path, data: body, options: options);
      debugPrint("==========Api Response ==========");
      debugPrint("Status Code: ${response.statusCode.toString()}");
      debugPrint("Data: ${response.data}");
      return response;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
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
    options.baseUrl = ApiConstants.baseUrl;
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

/*
Future<Response> postRequest({required String path, dynamic body}) async {
    var token = await Utils.getToken();
    final options = Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    dio.interceptors.add(PrettyDioLogger());

    try {
      // 404
      // debugPrint("==========Api Request ==========");
      // debugPrint("Request URL: ${baseOptions.baseUrl +ApiEndPoints.tags}");
      var response = await dio.post(path, data: body, options: options);
      // debugPrint("==========Api Response ==========");
      // debugPrint("Status Code: ${response.statusCode.toString()}");
      // debugPrint("Data: ${response.data}");
      // log("Data: ${response.data}");

      //debugPrint(response.data);
      return response;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
    }
  }
*/
