import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';

class TextStyles {
  static const TextStyle bodyText = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyComment = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.backgroundDark,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle altButtonText = TextStyle(
    color: AppColors.accentBlue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
