import 'dart:convert';
import 'dart:io';

Future<bool> isUtf8(String path) async {
  final bytes = await File(path).readAsBytes();
  try {
    utf8.decode(bytes, allowMalformed: false);
    return true;
  } catch (_) {
    return false;
  }
}
