import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle heading({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.josefinSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle body({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height = 1.5,
    double? letterSpacing,
  }) {
    return GoogleFonts.josefinSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle num({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.josefinSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle brand({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
    double? letterSpacing,
  }) {
    return GoogleFonts.josefinSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle mono({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
