import 'dart:ui';

class AppTheme {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color accent;
  final Color backgroundDark;
  final Color backgroundLight;

  AppTheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.accent,
    required this.backgroundDark,
    required this.backgroundLight,
  });

  factory AppTheme.fromMap(Map<String, String> map) {
    Color parse(String hex) => Color(int.parse(hex.replaceFirst('#', '0xff')));
    return AppTheme(
      primary: parse(map['primary']!),
      secondary: parse(map['secondary']!),
      tertiary: parse(map['tertiary']!),
      accent: parse(map['accent']!),
      backgroundDark: parse(map['backgroundDark']!),
      backgroundLight: parse(map['backgroundLight']!),
    );
  }
}
