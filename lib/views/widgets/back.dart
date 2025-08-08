import 'package:flutter/material.dart';

class Back {
  static Widget buildBack(VoidCallback callback) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color.fromARGB(255, 159, 159, 159)),
          ),
          child: IconButton(
            iconSize: 20,
            onPressed: () {
              callback();
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
      ],
    );
  }
}
// 