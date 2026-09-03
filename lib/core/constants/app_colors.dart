import 'package:flutter/material.dart';

/// Lumora Color Tokens matching CSS tokens and themes/dark.css
class AppColors {
  AppColors._();

  // Brand
  static const Color brand = Color(0xFF5B5BF7);
  static const Color brandHover = Color(0xFF4A4AE6);
  static const Color brandSoft = Color(0xFFEAEAFE);
  static const Color brandDark = Color(0xFF7B7BFF);
  static const Color brandDarkHover = Color(0xFF9292FF);
  static const Color brandDarkSoft = Color(0xFF1F1F3A);

  // Status Light
  static const Color success = Color(0xFF22C55E);
  static const Color successSoft = Color(0xFFE4F8EC);
  static const Color warn = Color(0xFFF59E0B);
  static const Color warnSoft = Color(0xFFFEF3DC);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerSoft = Color(0xFFFDE6E6);
  static const Color info = Color(0xFF0EA5E9);
  static const Color infoSoft = Color(0xFFDDF2FB);

  // Status Dark
  static const Color successDark = Color(0xFF34D17A);
  static const Color successDarkSoft = Color(0xFF13301F);
  static const Color warnDark = Color(0xFFFBBF24);
  static const Color warnDarkSoft = Color(0xFF3A2E10);
  static const Color dangerDark = Color(0xFFF87171);
  static const Color dangerDarkSoft = Color(0xFF3A1B1B);
  static const Color infoDark = Color(0xFF38BDF8);
  static const Color infoDarkSoft = Color(0xFF0F2A38);

  // Light Palette
  static const Color lightBg = Color(0xFFF6F7FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurface2 = Color(0xFFF1F3F9);
  static const Color lightSurface3 = Color(0xFFE9ECF4);
  static const Color lightBorder = Color(0xFFE6E8EE);
  static const Color lightBorderStrong = Color(0xFFCDD3DE);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextMuted = Color(0xFF64748B);
  static const Color lightTextSoft = Color(0xFF94A3B8);
  static const Color lightTextInvert = Color(0xFFFFFFFF);

  // Dark Palette
  static const Color darkBg = Color(0xFF0E1116);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkSurface2 = Color(0xFF1C232C);
  static const Color darkSurface3 = Color(0xFF232C37);
  static const Color darkBorder = Color(0xFF262E38);
  static const Color darkBorderStrong = Color(0xFF34404D);
  static const Color darkText = Color(0xFFE5E7EB);
  static const Color darkTextMuted = Color(0xFF9AA4B2);
  static const Color darkTextSoft = Color(0xFF6B7480);
  static const Color darkTextInvert = Color(0xFF0F172A);

  // Chart Palette
  static const Color chart1 = Color(0xFF5B5BF7);
  static const Color chart2 = Color(0xFF22C55E);
  static const Color chart3 = Color(0xFFF59E0B);
  static const Color chart4 = Color(0xFF0EA5E9);
  static const Color chart5 = Color(0xFFEF4444);
  static const Color chart6 = Color(0xFFA855F7);
  static const Color chart7 = Color(0xFF14B8A6);
  static const Color chart8 = Color(0xFFF472B6);

  // KPI Card Gradients
  static const List<Color> kpiGradientRevenue = [Color(0xFF5B5BF7), Color(0xFF8B5CF6)];
  static const List<Color> kpiGradientCustomers = [Color(0xFF22C55E), Color(0xFF16A34A)];
  static const List<Color> kpiGradientProjects = [Color(0xFF0EA5E9), Color(0xFF0284C7)];
  static const List<Color> kpiGradientTasks = [Color(0xFFF59E0B), Color(0xFFD97706)];
}
