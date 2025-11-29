import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("SubFix", style: TextStyles.bodyTitle)],
          ),
        ],
      ),
    );
  }
}
