import 'package:flutter/material.dart';
import 'package:subfix/core/app_theme.dart';

class TextStyles {
  static TextStyle bodyText(AppTheme theme) {
    return TextStyle(
      color: theme.primary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bodyTitle(AppTheme theme) {
    return TextStyle(
      color: theme.primary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyComment(AppTheme theme) {
    return TextStyle(
      color: theme.secondary,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle buttonText(AppTheme theme) {
    return TextStyle(
      color: theme.backgroundPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle altButtonText(AppTheme theme) {
    return TextStyle(
      color: theme.accent,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}
