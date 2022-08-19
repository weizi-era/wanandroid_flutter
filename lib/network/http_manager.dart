import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class HttpManager {
  Dio? _dio;
  static HttpManager? _instance;

  factory HttpManager.getInstance() {
    return _instance ??= HttpManager._internal();
  }

  HttpManager._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 10000,
    );

    _dio = Dio(options);


    _dio!.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    //_dio!.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("请求之前");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("响应之前");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print("错误之前");
      return handler.next(e);
    }));


  }

  request(url, {method = "GET", queryParameters, headers}) async {
    try {
      Response response = await _dio!.request(url,
          options: Options(method: method, headers: headers), queryParameters: queryParameters);
      return response.data;
    } on DioError catch (e) {
      print("response error ---- $e");
      formatError(e);
      return null;
    }
  }



  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
}
