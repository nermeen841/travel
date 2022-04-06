import 'package:dio/dio.dart';
import 'package:travel/constants/network_services.dart';

class DioHelper {
  static late Dio dio;

  static inti() {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    String? token,
  }) async {
    return dio.get(url,
        queryParameters: query, options: Options(headers: headers));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
    String? token,
  }) async {
    return dio.post(url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: query);
  }
}
