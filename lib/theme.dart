import 'package:flutter/material.dart';

final ColorScheme appScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF1FAA59));

ThemeData appTheme() {
  return ThemeData(colorScheme: appScheme, useMaterial3: true, fontFamily: '');
}

const Color appGreen = Color(0xFF1FAA59);
const Color appDarkGreen = Color(0xFF0E8044);
const Color appLightGreen = Color(0xFFB9E2C0);