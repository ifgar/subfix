import 'dart:convert';
import 'dart:io';

import 'package:subfix/core/encoding.dart';
import 'package:subfix/core/offset.dart';

Offset processOffset(double offset) {
  int entero = offset.toInt();
  int ms = ((offset - entero) * 1000).toInt();

  int h = (entero / 3600).toInt();
  int m = ((entero % 3600) / 60).toInt();
  int s = entero % 60;

  return Offset(h, m, s, ms);
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

Future<void> sync(String path, double offset) async {
  final file = File(path);
  if (!await file.exists()) return;

  final bytes = await file.readAsBytes();
  final isUtf = await isUtf8(path);

  final content = isUtf
      ? utf8.decode(bytes)
      : latin1.decode(bytes, allowInvalid: true);

  final lines = content.split('\n');

  final buffer = StringBuffer();
  final off = processOffset(offset);

  for (final line in lines) {
    if (line.contains("-->")) {
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

      buffer.writeln("$startFinal --> $endFinal");
    } else {
      buffer.writeln(line);
    }
  }

  await saveSrt(path, buffer.toString(), offset);
}

Future<void> saveSrt(String path, String content, double offset) async {
  final file = File(path);
  final folder = file.parent.path;

  final name = file.uri.pathSegments.last.replaceAll('.srt', '');
  final newPath = "$folder/$name[$offset].srt";

  await File(newPath).writeAsString(content);
}

//TODO: UTF-8 file checker
