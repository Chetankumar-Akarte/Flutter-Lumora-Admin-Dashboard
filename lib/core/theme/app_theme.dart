import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.brand,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brand,
        onPrimary: Colors.white,
        secondary: AppColors.brandHover,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText,
        error: AppColors.danger,
        onError: Colors.white,
        outline: AppColors.lightBorder,
        outlineVariant: AppColors.lightBorderStrong,
        surfaceContainerHighest: AppColors.lightSurface2,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.rLg,
          side: const BorderSide(color: AppColors.lightBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        titleLarge: AppTypography.heading(fontSize: 20, color: AppColors.lightText, fontWeight: FontWeight.w700),
        titleMedium: AppTypography.heading(fontSize: 16, color: AppColors.lightText, fontWeight: FontWeight.w600),
        titleSmall: AppTypography.heading(fontSize: 14, color: AppColors.lightText, fontWeight: FontWeight.w600),
        bodyLarge: AppTypography.body(fontSize: 15, color: AppColors.lightText),
        bodyMedium: AppTypography.body(fontSize: 13, color: AppColors.lightTextMuted),
        bodySmall: AppTypography.body(fontSize: 12, color: AppColors.lightTextSoft),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
        ),
        hintStyle: AppTypography.body(fontSize: 13, color: AppColors.lightTextSoft),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1E293B),
        contentTextStyle: AppTypography.body(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: AppDimensions.rMd),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.brandDark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.brandDark,
        onPrimary: AppColors.darkTextInvert,
        secondary: AppColors.brandDarkHover,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
        error: AppColors.dangerDark,
        onError: Colors.white,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkBorderStrong,
        surfaceContainerHighest: AppColors.darkSurface2,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.rLg,
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        titleLarge: AppTypography.heading(fontSize: 20, color: AppColors.darkText, fontWeight: FontWeight.w700),
        titleMedium: AppTypography.heading(fontSize: 16, color: AppColors.darkText, fontWeight: FontWeight.w600),
        titleSmall: AppTypography.heading(fontSize: 14, color: AppColors.darkText, fontWeight: FontWeight.w600),
        bodyLarge: AppTypography.body(fontSize: 15, color: AppColors.darkText),
        bodyMedium: AppTypography.body(fontSize: 13, color: AppColors.darkTextMuted),
        bodySmall: AppTypography.body(fontSize: 12, color: AppColors.darkTextSoft),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.rMd,
          borderSide: const BorderSide(color: AppColors.brandDark, width: 1.5),
        ),
        hintStyle: AppTypography.body(fontSize: 13, color: AppColors.darkTextSoft),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkSurface3,
        contentTextStyle: AppTypography.body(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.rMd,
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }
}
