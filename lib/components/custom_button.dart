import 'package:flutter/material.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/color_utils.dart';
import 'package:subfix/core/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final AppTheme activeTheme;
  final bool filled;
  final int width;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.activeTheme,
    this.filled = true,
    this.width = 96,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? activeTheme.accent : activeTheme.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
        side: BorderSide(
          color: filled ? Colors.transparent : activeTheme.accent,
        ),
      ),
      child: InkWell(
        onTap: () => onPressed,
        borderRadius: BorderRadius.circular(8),
        splashColor: filled
            ? darken(activeTheme.accent, -0.05)
            : darken(activeTheme.backgroundPrimary, -0.025),
        hoverColor: filled
            ? darken(activeTheme.accent, 0.05)
            : darken(activeTheme.backgroundPrimary, 0.025),
        child: SizedBox(
          height: 32,
          width: width.toDouble(),
          child: Center(
            child: Text(
              title,
              style: filled
                  ? TextStyles.buttonText(activeTheme)
                  : TextStyles.altButtonText(activeTheme),
            ),
          ),
        ),
      ),
    );
  }
}
