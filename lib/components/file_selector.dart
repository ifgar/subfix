import 'package:flutter/material.dart';
import 'package:subfix/components/custom_button.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/text_styles.dart';

class FileSelector extends StatelessWidget {
  final VoidCallback onPressed;
  final String selectedFileName;
  final AppTheme activeTheme;

  const FileSelector({
    super.key,
    required this.onPressed,
    required this.selectedFileName,
    required this.activeTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 32,
          width: 350,
          decoration: BoxDecoration(
            color: activeTheme.backgroundSecondary,
            border: Border.all(color: activeTheme.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(selectedFileName, style: TextStyles.bodyText(activeTheme)),
          ),
        ),
        SizedBox(width: 8),
        CustomButton(title: "Select", onPressed: onPressed, activeTheme: activeTheme)
      ],
    );
  }
}
