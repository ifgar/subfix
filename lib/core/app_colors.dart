import 'dart:ui';

import 'package:gtk_theme_fl/gtk_theme_fl.dart';

class AppColors {
  // Basic colors
  static late Color primary;
  static late Color secondary;

  // Accents
  static late Color accent;
  static late Color accentRed;

  // Backgrounds
  static late Color backgroundDark;
  static late Color backgroundLight;

  // Buttons
  static late Color buttonBg;
  static late Color buttonFg;
  static late Color buttonHover;

  // Border
  static late Color border;

  static void init(GtkThemeData themeData) {
    primary = Color(themeData.theme_text_color);
    secondary = Color(themeData.theme_text_color);
    accent = Color(themeData.theme_selected_bg_color);
    accentRed = Color(themeData.error_color);
    backgroundDark = Color(themeData.theme_bg_color);
    backgroundLight = Color(themeData.theme_base_color);
    buttonBg = Color(themeData.button_bg);
    buttonFg = Color(themeData.button_bg);
    buttonHover = Color(themeData.button_hover);
    border = Color(themeData.borders);
  }
}
