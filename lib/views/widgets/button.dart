//
import 'package:flutter/material.dart';

// bool isborder = true;

// String text="";

class Button {
  static Widget buildButton(
    String text,
    VoidCallback callback, {
    bool isborder = false,
    int border = 0xFF5DA3FF,
    Color linear1 = Colors.blue,
    Color linear2 = Colors.purple,
    bool isbg = true,
    bool istext = true,
  }) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          border: isborder ? Border.all(color: Color(border)) : null,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [linear1, linear2]),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: istext ? Colors.white : Colors.pink,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
// 