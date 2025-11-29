import 'dart:io';

import 'package:flutter/material.dart';
import 'package:subfix/home_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    
    await windowManager.ensureInitialized();

    WindowOptions opts = const WindowOptions(
      size: Size(500, 700),  // tamaño inicial
      center: true,          // evita coords
    );

    windowManager.waitUntilReadyToShow(opts, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
