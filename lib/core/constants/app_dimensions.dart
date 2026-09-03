import 'package:flutter/material.dart';

/// Spacing, dimensions, radii, and breakpoints for Lumora
class AppDimensions {
  AppDimensions._();

  // Spacing (4px base)
  static const double sp0 = 0.0;
  static const double sp1 = 4.0;
  static const double sp2 = 8.0;
  static const double sp3 = 12.0;
  static const double sp4 = 16.0;
  static const double sp5 = 20.0;
  static const double sp6 = 24.0;
  static const double sp7 = 32.0;
  static const double sp8 = 40.0;
  static const double sp9 = 48.0;
  static const double sp10 = 64.0;

  // Radii
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 10.0;
  static const double radiusLg = 14.0;
  static const double radiusXl = 20.0;
  static const double radiusPill = 999.0;

  static final BorderRadius rXs = BorderRadius.circular(radiusXs);
  static final BorderRadius rSm = BorderRadius.circular(radiusSm);
  static final BorderRadius rMd = BorderRadius.circular(radiusMd);
  static final BorderRadius rLg = BorderRadius.circular(radiusLg);
  static final BorderRadius rXl = BorderRadius.circular(radiusXl);
  static final BorderRadius rPill = BorderRadius.circular(radiusPill);

  // Layout Dimensions
  static const double topbarHeight = 64.0;
  static const double sidebarWidth = 260.0;
  static const double sidebarRailWidth = 76.0;
  static const double maxContentWidth = 1440.0;
  static const double contentGutter = 24.0;
  static const double contentGutterSm = 16.0;

  // Responsive Breakpoints
  static const double breakpointMobile = 768.0;
  static const double breakpointTablet = 1100.0;
  static const double breakpointDesktop = 1440.0;
}
