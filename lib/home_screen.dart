import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilePath = "/...";
  String selectedFileName = "";
  double selectedOffset = 0.0;

  final offsetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: SizedBox(
          width: 452,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Select a file:",
                style: TextStyles.bodyText,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 32,
                    width: 350,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(selectedFileName, style: TextStyles.bodyText),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      const type = XTypeGroup(
                        label: 'SRT',
                        extensions: ['srt'],
                      );
                      final file = await openFile(acceptedTypeGroups: [type]);
                      if (file == null) return;
                      setState(() {
                        selectedFilePath = file.path;
                        selectedFileName = file.name;
                      });
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
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Offset (s):", style: TextStyles.bodyText),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 48,
                    height: 32,
                    child: TextField(
                      controller: offsetController,
                      cursorColor: AppColors.accentBlue,
                      style: TextStyles.bodyText,
                      onChanged: (value) {
                        final v = value.replaceAll(",", ".");

                        final offset = double.tryParse(v);
                        if (offset != null) {
                          setState(() {
                            selectedOffset = offset;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 2, right: 2),
                        filled: true,
                        fillColor: AppColors.backgroundLight,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    height: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          selectedOffset -= 0.1;
                          offsetController.text = selectedOffset.toStringAsFixed(2);
                        });
                      },
                      mini: true,
                      backgroundColor: AppColors.accentBlue,
                      foregroundColor: AppColors.backgroundDark,
                      shape: CircleBorder(),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          selectedOffset += 0.1;
                          offsetController.text = selectedOffset.toStringAsFixed(2);
                        });
                      },
                      mini: true,
                      backgroundColor: AppColors.accentBlue,
                      foregroundColor: AppColors.backgroundDark,
                      shape: CircleBorder(),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
