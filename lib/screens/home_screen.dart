import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:subfix/components/file_selector.dart';
import 'package:subfix/components/file_selector_comment.dart';
import 'package:subfix/components/main_menu_bar.dart';
import 'package:subfix/components/offset_selector.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/encoding.dart';
import 'package:subfix/core/sync_ass.dart';
import 'package:subfix/core/sync_srt.dart';
import 'package:subfix/core/sync_sub.dart';
import 'package:subfix/core/text_styles.dart';
import 'package:subfix/core/themes.dart';

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
  String activeThemeName = "default";
  AppTheme activeTheme = defaultTheme;
  Map<String, AppTheme> themes = {"default": defaultTheme};

  final offsetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initThemes();
  }

  Future<void> _initThemes() async {
    final loaded = await loadThemes();
    setState(() {
      themes = loaded;
      activeTheme = themes["default"] ?? defaultTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainMenuBar(
      themes: themes,
      activeThemeName: activeThemeName,
      onThemeSelected: (value) {
        setState(() {
          activeThemeName = value;
          activeTheme = themes[value] ?? defaultTheme;
        });
      },
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
                    });
                  },
                ),
                SizedBox(height: 4),
                FileSelectorComment(isUtf: isUtf),
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
                      selectedOffset = double.parse(
                        (selectedOffset - 0.1).toStringAsFixed(2),
                      );
                      offsetController.text = selectedOffset.toStringAsFixed(2);
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      selectedOffset = double.parse(
                        (selectedOffset + 0.1).toStringAsFixed(2),
                      );
                      offsetController.text = selectedOffset.toStringAsFixed(2);
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedFilePath = "/...";
                          selectedFileName = "";
                          selectedFileExtension = "";
                          selectedOffset = 0.0;
                          offsetController.text = "";
                          isUtf = null;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        side: BorderSide(color: AppColors.accent),
                      ),
                      child: Text("Clear", style: TextStyles.altButtonText),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedFileExtension.toLowerCase() == "srt") {
                          syncSrt(selectedFilePath, selectedOffset);
                        } else if (selectedFileExtension.toLowerCase() ==
                            "sub") {
                          syncSub(selectedFilePath, selectedOffset);
                        } else if (selectedFileExtension.toLowerCase() ==
                            "ass") {
                          syncAss(selectedFilePath, selectedOffset);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        backgroundColor: AppColors.accent,
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
