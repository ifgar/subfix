import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gtk_theme_fl/gtk_theme_fl.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/screens/home_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    WindowOptions opts = const WindowOptions(
      center: true,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(opts, () async {
      await windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  GtkThemeData themeData = await GtkThemeData.initialize();
  AppColors.init(themeData);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
