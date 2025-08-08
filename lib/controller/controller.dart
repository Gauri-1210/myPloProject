import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  String _username = "";
  String get username => _username;
  void setusername(String name) {
    _username = name;
    notifyListeners();
  }
}
