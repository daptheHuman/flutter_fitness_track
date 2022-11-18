import 'package:flutter/cupertino.dart';
import 'package:flutter_fitness_track/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool isAuth = false;

  Map _profile = {};
  set _setProfile(user) {
    // destructuring user
    _profile = {
      '_id': user['_id'],
      'username': user['username'],
    };
    notifyListeners();
  }

  Map get getProfile => _profile;

  void setToken(
      {required String accessToken, required String refreshToken}) async {
    if (accessToken != '' && refreshToken != '') {
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      isAuth = true;
      notifyListeners();
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      Response res = await AuthService().signin(email, password);
      String accessToken = res.data['accessToken'];
      String refreshToken = res.data['refreshToken'];

      _setProfile = res.data['user'];
      setToken(accessToken: accessToken, refreshToken: refreshToken);
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> signup({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      await AuthService().signup(email, username, password);
      Response res = await AuthService().signin(email, password);

      String accessToken = res.data['accessToken'];
      String refreshToken = res.data['refreshToken'];

      _setProfile = res.data['user'];
      // print(getProfile);
      setToken(accessToken: accessToken, refreshToken: refreshToken);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future signout() async {
    try {
      await storage.write(key: 'accessToken', value: null);
      await storage.write(key: 'refreshToken', value: null);
      isAuth = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
