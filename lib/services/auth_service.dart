import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_fitness_track/services/base_api.dart';

class AuthAPI {
  final dio = Dio(
    BaseOptions(
      baseUrl: '${BaseAPI().baseURL}/auth',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
}

class AuthService extends AuthAPI {
  Future<Response> signin(String email, String password) async {
    try {
      Map body = {
        'email': email,
        'password': password,
      };

      Response response = await dio.post('/signin', data: body);

      return response;
    } on DioError catch (err) {
      print(err);
      if (err.response != null) throw err.response?.data['message'];
      throw err.error;
    }
  }

  Future<Response> signup(
      String email, String username, String password) async {
    try {
      var body = jsonEncode({
        'email': email,
        'username': username,
        'password': password,
      });

      Response response = await dio.post('/signup', data: body);

      return response;
    } on DioError catch (err) {
      if (err.response != null) throw err.response?.data['message'];
      throw err.error;
    }
  }
}
