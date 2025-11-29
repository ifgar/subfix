import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilePath = "Select a file...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("SubFix", style: TextStyles.bodyTitle)],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 32,
                width: 300,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  border: Border.all(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(selectedFilePath, style: TextStyles.bodyText),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  const type = XTypeGroup(label: 'SRT', extensions: ['srt']);
                  final file = await openFile(acceptedTypeGroups: [type]);
                  if (file == null) return;
                  setState(() {
                    selectedFilePath = file.path;
                  });
                  selectedFilePath = file.path;
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  backgroundColor: AppColors.accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Text("Select", style: TextStyles.buttonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
