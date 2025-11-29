import 'dart:io';

import 'package:flutter/material.dart';
import 'package:subfix/home_screen.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    
    // Window min size
    setWindowMinSize(const Size(500, 700));
    setWindowMaxSize(Size.infinite);

    // Window launch size
    setWindowFrame(const Rect.fromLTWH(100, 100, 500, 700));
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
