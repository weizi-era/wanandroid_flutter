
import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/network/api.dart';

class HttpManager {

    Dio? _dio;
    static HttpManager? _instance;

    factory HttpManager.getInstance() {
      return  _instance ??= HttpManager._internal();
    }

    HttpManager._internal() {
      BaseOptions options = BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

      _dio = Dio(options);
    }

    request(url, {String method = "get", Map<String, dynamic>? queryParameters}) async {
      try {
        Options options = Options(method: method,);
        Response response = await _dio!.request(url, options: options, queryParameters: queryParameters);
        return response.data;
      } catch (e) {
        return null;
      }
    }
}