
import 'dart:convert';
import 'dart:io';
import 'package:subfix/core/encoding.dart';

int processSubOffset(double offset){
  double ms = offset * 1000;

  return ms.toInt();
}


Future<void> syncSub(String path, double offset) async {
  final file = File(path);
  if (!await file.exists()) return;

  // Read file with encoding detection
  final bytes = await file.readAsBytes();
  final isUtf = await isUtf8(path);
  final content = isUtf
      ? utf8.decode(bytes)
      : latin1.decode(bytes, allowInvalid: true);

  // Split into lines
  final lines = content.split('\n');

  final buffer = StringBuffer();
  final off = processSubOffset(offset);

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final isLast = i == lines.length - 1;

    if (line.contains("}{")) {
      // Parse timing line
      final partes = line.split("}{");

      final start = partes[0];
      final end = partes[1];

      final startMs = int.parse(start.replaceAll("{", ""));

      final endSplit = end.split("}");
      final endMs = int.parse(endSplit[0]);
      final subText = endSplit[1];

      // Apply offset
      final startFinal;
      if(startMs + off > 0){
        startFinal = startMs + off;
      } else {
        startFinal = 0;
      }
      final endFinal = endMs + off;

      // Write adjusted timing line
      buffer.writeln("{$startFinal}{$endFinal}$subText");
    } else {
      // Skip only the final trailing blank line
      if (isLast && line.trim().isEmpty) {
        continue;
      }
      // Preserve all other lines (including block separators)
      buffer.writeln(line);
    }
  }

  // Always save output in UTF-8 to maximize compatibility with external tools (e.g., mkvmerge)
  await saveSub(path, buffer.toString(), offset);
}

Future<void> saveSub(String path, String content, double offset) async {
  final file = File(path);
  final folder = file.parent.path;

  final name = file.uri.pathSegments.last.replaceAll('.sub', '');
  final newPath = "$folder/$name[$offset].sub";

  await File(newPath).writeAsString(content);
}