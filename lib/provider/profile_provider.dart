import 'dart:core';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  Map _profile = {
    '_id': '',
    'username': '',
  };

  String get userId => _profile['_id'];
  String get username => _profile['username'];

  set setProfile(user) {
    // destructuring user
    _profile = {
      '_id': user['_id'],
      'username': user['username'],
    };
    notifyListeners();
  }

  void clearProfile() {
    _profile = {
      '_id': '',
      'username': '',
    };
    notifyListeners();
  }
}
