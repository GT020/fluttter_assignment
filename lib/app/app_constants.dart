import 'package:flutter/material.dart';

const Color primary = Color(0xFF015ecb);
const Color primaryDark = Color(0xFF2F579F);
const Color accent = Color(0xFFfab206);
const Color seaGreen = Color(0xFF19b892);
final ThemeData lightTheme = ThemeData(
  primaryColor: primary,
  colorScheme: const ColorScheme.light(
    secondary: accent,
  ),
);
