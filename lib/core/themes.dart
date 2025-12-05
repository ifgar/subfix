import 'package:flutter/services.dart';
import 'package:subfix/core/app_theme.dart';

final AppTheme defaultTheme = AppTheme(
  primary: Color(0xFFC0CAF5),
  secondary: Color(0xFF8289B0),
  tertiary: Color(0xFF565F89),
  accent: Color(0xFF7DCFFF),
  backgroundDark: Color(0xFF1F2335),
  backgroundLight: Color(0xFF292E42),
);

Future<Map<String, AppTheme>> loadThemes() async {
  final text = await rootBundle.loadString("themes.conf");
  final lines = text.split("\n");

  final themes = <String, AppTheme>{};
  String? currentName;
  final currentMap = <String, String>{};

  void commit() {
    if (currentName != null && currentMap.isNotEmpty) {
      themes[currentName] = AppTheme.fromMap(currentMap);
      currentMap.clear();
    }
  }

  for (final line in lines) {
    final trimmed = line.trim();
    if (trimmed.isEmpty) continue;

    if (trimmed.startsWith("[") && trimmed.endsWith("]")) {
      commit();
      currentName = trimmed.substring(1, trimmed.length - 1);
    } else if (trimmed.contains("=")) {
      final parts = trimmed.split("=");
      currentMap[parts[0].trim()] = parts[1].trim();
    }
  }

  commit();

  // fallback
  themes['default'] ??= defaultTheme;
  return themes;
}
