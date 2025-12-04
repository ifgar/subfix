import 'dart:convert';
import 'dart:io';

import 'package:subfix/core/encoding.dart';
import 'package:subfix/core/srt_offset.dart';

SrtOffset processOffset(double offset) {

  int h = (offset / 3600).toInt();
  int m = ((offset % 3600) / 60).toInt();
  double s = offset % 60;

  return SrtOffset(h, m, s);
}

String formatTime(int h, int m, int s, int ms) {
  // ms
  if (ms < 0) {
    int borrow = ((ms.abs() + 999) / 1000).toInt();
    ms += borrow * 1000;
    s -= borrow;
  }

  if (ms >= 1000) {
    int carry = (ms / 1000).toInt();
    ms %= 1000;
    s += carry;
  }

  // s
  if (s < 0) {
    int borrow = ((s.abs() + 59) / 60).toInt();
    s += borrow * 60;
    m -= borrow;
  }

  if (s >= 60) {
    int carry = (s / 60).toInt();
    s %= 60;
    m += carry;
  }

  // m
  if (m < 0) {
    int borrow = ((m.abs() + 59) / 60).toInt();
    m += borrow * 60;
    h -= borrow;
  }

  if (m >= 60) {
    int carry = (m / 60).toInt();
    m %= 60;
    h += carry;
  }

  // h
  if (h < 0) {
    h = 0;
    m = 0;
    s = 0;
    ms = 0;
  }

  return "${h.toString().padLeft(2, '0')}:"
      "${m.toString().padLeft(2, '0')}:"
      "${s.toString().padLeft(2, '0')},"
      "${ms.toString().padLeft(3, '0')}";
}

Future<void> syncSrt(String path, double offset) async {
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
  final off = processOffset(offset);

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final isLast = i == lines.length - 1;

    if (line.contains("-->")) {
      // Parse timing line
      final partes = line.split(" --> ");

      final start = partes[0];
      final end = partes[1];

      final startTokens = start.split(RegExp(r'[:,]'));
      final hS = int.parse(startTokens[0]);
      final mS = int.parse(startTokens[1]);
      final sS = int.parse(startTokens[2]);
      final msS = int.parse(startTokens[3]);

      final endTokens = end.split(RegExp(r'[:,]'));
      final hE = int.parse(endTokens[0]);
      final mE = int.parse(endTokens[1]);
      final sE = int.parse(endTokens[2]);
      final msE = int.parse(endTokens[3]);

      // Apply offset
      final startFinal = formatTime(
        hS + off.h,
        mS + off.m,
        sS + off.s,
        msS + off.ms,
      );

      final endFinal = formatTime(
        hE + off.h,
        mE + off.m,
        sE + off.s,
        msE + off.ms,
      );

      // Write adjusted timing line
      buffer.writeln("$startFinal --> $endFinal");
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
  await saveAss(path, buffer.toString(), offset);
}

Future<void> saveAss(String path, String content, double offset) async {
  final file = File(path);
  final folder = file.parent.path;

  final name = file.uri.pathSegments.last.replaceAll('.ass', '');
  final newPath = "$folder/$name[$offset].ass";

  await File(newPath).writeAsString(content);
}