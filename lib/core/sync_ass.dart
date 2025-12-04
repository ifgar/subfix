import 'dart:convert';
import 'dart:io';

import 'package:subfix/core/encoding.dart';

// Parse timing
double assToSeconds(String t) {
  final p = t.split(":");
  final h = int.parse(p[0]);
  final m = int.parse(p[1]);
  final s = double.parse(p[2]);

  return h * 3600 + m * 60 + s;
}

//Format seconds
String secondsToAss(double total) {
  if (total < 0) total = 0;
  final h = (total / 3600).toInt();
  final m = ((total % 3600) / 60).toInt();
  final s = total % 60;

  return "$h:${m.toString().padLeft(2, "0")}:${s.toStringAsFixed(2).padLeft(5, "0")}";
}

// Apply offset
String shiftDialogueLine(String line, double offset) {
  final parts = line.split(",");

  final startSec = assToSeconds(parts[1]);
  final endSec = assToSeconds(parts[2]);

  final newStart = secondsToAss(startSec + offset);
  final newEnd = secondsToAss(endSec + offset);

  parts[1] = newStart;
  parts[2] = newEnd;

  return parts.join(",");
}

Future<void> syncAss(String path, double offset) async {
  final file = File(path);
  if (!await file.exists()) return;

  final bytes = await file.readAsBytes();
  final isUtf = await isUtf8(path);
  final content = (isUtf
      ? utf8.decode(bytes)
      : latin1.decode(bytes, allowInvalid: true))
      .replaceAll("\r", "");

  final lines = content.split("\n");
  final buffer = StringBuffer();

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final isLast = i == lines.length -1;

    if (line.startsWith("Dialogue:") || line.startsWith("Comment:")){
      buffer.writeln(shiftDialogueLine(line, offset));
      
    } else {
      // Skip only the final trailing blank line
      if (isLast && line.trim().isEmpty) {
        continue;
      }
      // Preserve all other lines (including block separators)
      buffer.writeln(line);
    }
  }

  await saveAss(path, buffer.toString(), offset);
}

Future<void> saveAss(String path, String content, double offset) async {
  final file = File(path);
  final folder = file.parent.path;

  final name = file.uri.pathSegments.last.replaceAll('.ass', '');
  final newPath = "$folder/$name[$offset].ass";

  await File(newPath).writeAsString(content);
}
