import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/color_utils.dart';
import 'package:subfix/core/text_styles.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final bool filled;
  final int width;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.filled = true,
    this.width = 90,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _buttonScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _buttonScale,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: widget.filled
            ? AppColors.accent
            : AppColors.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(
            color: widget.filled
                ? Colors.transparent
                : AppColors.accent,
          ),
        ),
        child: InkWell(
          onTap: () {
            widget.onPressed();
            setState(() {
              _buttonScale = 0.95;
              Future.delayed(const Duration(milliseconds: 80), () {
                if (!mounted) return;
                setState(() => _buttonScale = 1.0);
              });
            });
          },
          borderRadius: BorderRadius.circular(8),
          splashColor: widget.filled
              ? darken(AppColors.accent, -0.05)
              : darken(AppColors.backgroundDark, -0.025),
          hoverColor: widget.filled
              ? darken(AppColors.accent, 0.05)
              : darken(AppColors.backgroundDark, 0.025),
          child: SizedBox(
            height: 32,
            width: widget.width.toDouble(),
            child: Center(
              child: Text(
                widget.title,
                style: widget.filled
                    ? TextStyles.buttonText()
                    : TextStyles.altButtonText(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
