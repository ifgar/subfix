import 'package:flutter/material.dart';
import 'package:subfix/core/app_theme.dart';
import 'package:subfix/core/text_styles.dart';

class OffsetSelector extends StatelessWidget {
  final TextEditingController offsetController;
  final Function(String) onChanged;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final AppTheme activeTheme;

  const OffsetSelector({
    super.key,
    required this.offsetController,
    required this.onChanged,
    required this.onDecrease,
    required this.onIncrease,
    required this.activeTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Offset (s):", style: TextStyles.bodyText),
        SizedBox(width: 8),
        SizedBox(
          height: 28,
          width: 28,
          child: FloatingActionButton(
            onPressed: onDecrease,
            mini: true,
            backgroundColor: activeTheme.backgroundDark,
            shape: CircleBorder(),
            child: Icon(
              Icons.remove_circle,
              size: 28,
              color: activeTheme.secondary,
            ),
          ),
        ),
        SizedBox(width: 4),
        SizedBox(
          width: 56,
          height: 32,
          child: TextField(
            controller: offsetController,
            cursorColor: activeTheme.accent,
            style: TextStyles.bodyText,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2, right: 2),
              filled: true,
              fillColor: activeTheme.backgroundLight,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: activeTheme.secondary),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: activeTheme.secondary),
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
            onPressed: onIncrease,
            mini: true,
            backgroundColor: activeTheme.backgroundDark,
            shape: CircleBorder(),
            child: Icon(Icons.add_circle, size: 28, color: activeTheme.secondary),
          ),
        ),
      ],
    );
  }
}
