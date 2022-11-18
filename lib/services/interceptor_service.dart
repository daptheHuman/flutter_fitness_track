import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JWTInterceptors extends Interceptor {
  final storage = const FlutterSecureStorage();

  Future<String?> get accessToken async {
    return await storage.read(key: 'accessToken');
  }

  get refreshToken async {
    return await storage.read(key: 'refreshToken');
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await accessToken;
    options.headers['authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // 401 error
      // refresh token
      // AuthAPI.refreshToken();
      // save new token
      // retry request
      // return super.onError(err, handler);
    }
    return super.onError(err, handler);
  }
}
