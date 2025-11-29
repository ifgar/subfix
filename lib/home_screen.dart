import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:subfix/components/file_selector.dart';
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
              FileSelector(
                onPressed: () async {
                  const type = XTypeGroup(label: 'SRT', extensions: ['srt']);
                  final file = await openFile(acceptedTypeGroups: [type]);
                  if (file == null) return;
                  setState(() {
                    selectedFilePath = file.path;
                    selectedFileName = file.name;
                  });
                },
                selectedFileName: selectedFileName,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Offset (s):", style: TextStyles.bodyText),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 56,
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
                    width: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          selectedOffset -= 0.1;
                          offsetController.text = selectedOffset
                              .toStringAsFixed(2);
                        });
                      },
                      mini: true,
                      backgroundColor: AppColors.backgroundDark,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.remove_circle,
                        size: 28,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          selectedOffset += 0.1;
                          offsetController.text = selectedOffset
                              .toStringAsFixed(2);
                        });
                      },
                      mini: true,
                      backgroundColor: AppColors.backgroundDark,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add_circle,
                        size: 28,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      backgroundColor: AppColors.accentBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                    ),
                    child: Text("Apply", style: TextStyles.buttonText),
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
