import 'package:flutter/material.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final AppTheme activeTheme;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.activeTheme,
  });

  @override
  Widget build(BuildContext context) {
    Color accentDarker = HSLColor.fromColor(activeTheme.accent)
        .withLightness(
          (HSLColor.fromColor(activeTheme.accent).lightness - 0.1).clamp(
            0.0,
            1.0,
          ),
        )
        .toColor();
    return Material(
      color: activeTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
        side: BorderSide(color: accentDarker),
      ),
      child: InkWell(
        onTap: () => onPressed,
        borderRadius: BorderRadius.circular(8),
        splashColor: accentDarker,
        child: SizedBox(
          height: 32,
          width: 96,
          child: Center(
            child: Text(title, style: TextStyles.buttonText(activeTheme)),
          ),
        ),
      ),
    );
  }
}
