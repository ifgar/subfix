import 'package:flutter/material.dart';
import 'package:subfix/core/app_colors.dart';
import 'package:subfix/core/text_styles.dart';

class FileSelectorComment extends StatelessWidget {
  final bool? isUtf;

  const FileSelectorComment({super.key, required this.isUtf});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isUtf == null)
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppColors.secondary),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "Supported formats: .srt, .sub, .ass",
                  style: TextStyles.bodyComment,
                ),
              ),
            ],
          ),
        if (isUtf == true)
          Row(
            children: [
              Icon(Icons.check, size: 16, color: Colors.green),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "File is ready to be converted",
                  style: TextStyles.bodyComment,
                ),
              ),
            ],
          ),
        if (isUtf == false)
          Row(
            children: [
              Icon(Icons.warning_rounded, size: 16, color: Colors.amber),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "File is not UTF-8. Output will be converted.",
                  style: TextStyles.bodyComment,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
