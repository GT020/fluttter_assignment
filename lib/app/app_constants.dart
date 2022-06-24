import 'package:flutter/material.dart';

Color primary = const Color(0xFF015ecb);
Color primaryDark = const Color(0xFF2F579F);
Color accent = const Color(0xFFfab206);

final ThemeData lightTheme = ThemeData(
  primaryColor: primary,
  colorScheme: ColorScheme.light(
    secondary: accent,
  ),
);
