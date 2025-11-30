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
  return "${h.toString().padLeft(2,'0')}:"
       "${m.toString().padLeft(2,'0')}:"
       "${s.toString().padLeft(2,'0')},"
       "${ms.toString().padLeft(3,'0')}";
}
