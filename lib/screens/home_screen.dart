import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:subfix/components/custom_button.dart';
import 'package:subfix/components/file_selector.dart';
import 'package:subfix/components/file_selector_comment.dart';
import 'package:subfix/components/offset_selector.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/encoding.dart';
import 'package:subfix/core/sync_ass.dart';
import 'package:subfix/core/sync_srt.dart';
import 'package:subfix/core/sync_sub.dart';
import 'package:subfix/core/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilePath = "/...";
  String selectedFileName = "";
  String selectedFileExtension = "";
  double selectedOffset = 0.0;
  bool? isUtf;

  final offsetController = TextEditingController();

  bool applied = false;

  void _onApplyPressed() {
    if (selectedFileExtension.toLowerCase() == "srt") {
      syncSrt(selectedFilePath, selectedOffset);
    } else if (selectedFileExtension.toLowerCase() == "sub") {
      syncSub(selectedFilePath, selectedOffset);
    } else if (selectedFileExtension.toLowerCase() == "ass") {
      syncAss(selectedFilePath, selectedOffset);
    }
    setState(() {
      applied = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      selectedFilePath = "/...";
      selectedFileName = "";
      selectedFileExtension = "";
      selectedOffset = 0.0;
      offsetController.text = "";
      isUtf = null;
      applied = false;
    });
  }

  void _onOffsetValueChanged(String value) {
    final v = value.replaceAll(",", ".");

    final offset = double.tryParse(v);
    if (offset != null) {
      setState(() {
        selectedOffset = offset;
      });
    }
  }

  void _onOffsetDecreasePressed() {
    setState(() {
      selectedOffset = double.parse((selectedOffset - 0.1).toStringAsFixed(2));
      offsetController.text = selectedOffset.toStringAsFixed(2);
    });
  }

  void _onOffsetIncreasePressed() {
    setState(() {
      selectedOffset = double.parse((selectedOffset + 0.1).toStringAsFixed(2));
      offsetController.text = selectedOffset.toStringAsFixed(2);
    });
  }

  Future<void> _onSelectPressed() async {
    const type = XTypeGroup(
      label: ".srt, .sub, .ass",
      extensions: ["srt", "sub", "ass"],
    );
    final file = await openFile(acceptedTypeGroups: [type]);
    if (file == null) return;

    final ok = await isUtf8(file.path);

    setState(() {
      selectedFilePath = file.path;
      selectedFileName = file.name;
      selectedFileExtension = selectedFileName.split(".").last;
      isUtf = ok;
      applied = false;
    });
  }

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
                style: TextStyles.bodyText(),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4),
              FileSelector(
                selectedFileName: selectedFileName,
                onPressed: () => _onSelectPressed(),
              ),
              SizedBox(height: 4),
              FileSelectorComment(isUtf: isUtf),
              SizedBox(height: 16),
              OffsetSelector(
                offsetController: offsetController,
                onChanged: (value) => _onOffsetValueChanged(value),
                onDecrease: () => _onOffsetDecreasePressed(),
                onIncrease: () => _onOffsetIncreasePressed(),
              ),
              SizedBox(height: 16),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        title: "Clear",
                        onPressed: _onClearPressed,
                        width: 80,
                        filled: false,
                      ),
                      SizedBox(width: 8),
                      CustomButton(
                        title: "Apply",
                        onPressed: _onApplyPressed
                      ),
                    ],
                  ),
                  if (applied && selectedFileName.isNotEmpty)
                    Positioned(
                      left: 330,
                      child: Text(
                        "Offset applied",
                        style: TextStyle(color: AppColors.secondary),
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
