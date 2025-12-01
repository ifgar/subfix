import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:subfix/components/custom_menu_bar.dart';
import 'package:subfix/components/file_selector.dart';
import 'package:subfix/components/offset_selector.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/sync_subs.dart';
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
    return CustomMenuBar(
      child: Scaffold(
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
                  selectedFileName: selectedFileName,
                  onPressed: () async {
                    const type = XTypeGroup(label: 'SRT', extensions: ['srt']);
                    final file = await openFile(acceptedTypeGroups: [type]);
                    if (file == null) return;
                    setState(() {
                      selectedFilePath = file.path;
                      selectedFileName = file.name;
                    });
                  },
                ),
                SizedBox(height: 16),
                OffsetSelector(
                  offsetController: offsetController,
                  onChanged: (value) {
                    final v = value.replaceAll(",", ".");
      
                    final offset = double.tryParse(v);
                    if (offset != null) {
                      setState(() {
                        selectedOffset = offset;
                      });
                    }
                  },
                  onDecrease: () {
                    setState(() {
                      selectedOffset -= 0.1;
                      offsetController.text = selectedOffset.toStringAsFixed(2);
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      selectedOffset += 0.1;
                      offsetController.text = selectedOffset.toStringAsFixed(2);
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        sync(selectedFilePath, selectedOffset);
                      },
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
      ),
    );
  }
}
