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

  return "";
}
