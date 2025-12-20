import 'package:flutter/material.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/color_utils.dart';
import 'package:subfix/core/text_styles.dart';

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _buttonScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _buttonScale,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: widget.filled
            ? widget.activeTheme.accent
            : widget.activeTheme.backgroundPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(
            color: widget.filled
                ? Colors.transparent
                : widget.activeTheme.accent,
          ),
        ),
        child: InkWell(
          onTap: () {
            widget.onPressed;
            setState(() {
              _buttonScale = 0.85;
              Future.delayed(const Duration(milliseconds: 80), () {
                if (!mounted) return;
                setState(() => _buttonScale = 1.0);
              });
            });
          },
          borderRadius: BorderRadius.circular(8),
          splashColor: widget.filled
              ? darken(widget.activeTheme.accent, -0.05)
              : darken(widget.activeTheme.backgroundPrimary, -0.025),
          hoverColor: widget.filled
              ? darken(widget.activeTheme.accent, 0.05)
              : darken(widget.activeTheme.backgroundPrimary, 0.025),
          child: SizedBox(
            height: 32,
            width: widget.width.toDouble(),
            child: Center(
              child: Text(
                widget.title,
                style: widget.filled
                    ? TextStyles.buttonText(widget.activeTheme)
                    : TextStyles.altButtonText(widget.activeTheme),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
