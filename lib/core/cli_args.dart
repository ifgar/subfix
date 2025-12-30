import 'dart:io';

import 'package:subfix/core/sync_ass.dart';
import 'package:subfix/core/sync_srt.dart';
import 'package:subfix/core/sync_sub.dart';

class CliArgs {
  final String? subFile;
  final double? offset;

  const CliArgs({required this.subFile, required this.offset});
}

CliArgs parseCliArgs(List<String> args) {
  if (args.length != 2) {
    return const CliArgs(subFile: null, offset: null);
  }

  final subFile = args[0].trim();
  final offset = double.tryParse(args[1]);

  if (subFile.isEmpty || offset == null) {
    return const CliArgs(subFile: null, offset: null);
  }

  return CliArgs(subFile: subFile, offset: offset);
}

bool runCliIfRequested(List<String> args) {
  final cliArgs = parseCliArgs(args);

  if (cliArgs.subFile != null && cliArgs.offset != null) {
    if (args.isNotEmpty) {
      stderr.writeln('Uso: subfix <archivo.sub|srt|ass> <offset>');
    }
    return false;
  }

  final subFile = cliArgs.subFile!;
  final offset = cliArgs.offset!;

  final ext = subFile.split(".").last;

  if (ext == "srt") {
    syncSrt(subFile, offset);
  } else if (ext == "sub") {
    syncSub(subFile, offset);
  } else if (ext == "ass") {
    syncAss(subFile, offset);
  } else {
    stderr.writeln('Formato no soportado: .$ext');
    return false;
  }

  return true;
}
