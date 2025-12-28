import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle bodyText() {
    return TextStyle(
      color: Color(0xFFC0CAF5),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bodyTitle() {
    return TextStyle(
      color: Color(0xFFC0CAF5),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyComment() {
    return TextStyle(
      color: Color(0xFF8289B0),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle buttonText() {
    return TextStyle(
      color: Color(0xFF1F2335),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle altButtonText() {
    return TextStyle(
      color: Color(0xFF7DCFFF),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}
