import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle base() =>
      TextStyle(fontSize: 13, color: Color.fromARGB(255, 159, 159, 159));

  static TextStyle bold() =>
      TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle normal() => TextStyle(fontSize: 12, color: Colors.black);
}
