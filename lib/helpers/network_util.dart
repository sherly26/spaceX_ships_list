import 'package:dio/dio.dart';

class NetworkUtil {
  static Dio getClient([api = 'https://api.spacexdata.com/v3/ships']) {
    Dio dio = Dio();
    dio.options.connectTimeout = 80 * 3000;
    dio.options.receiveTimeout = 30 * 3000;
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return status < 500;
    };
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
