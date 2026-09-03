import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

enum ScreenType { mobile, tablet, desktop }

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppDimensions.breakpointMobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.breakpointMobile &&
      MediaQuery.of(context).size.width < AppDimensions.breakpointTablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.breakpointTablet;

  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimensions.breakpointMobile) return ScreenType.mobile;
    if (width < AppDimensions.breakpointTablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppDimensions.breakpointTablet) {
          return desktop;
        }
        if (constraints.maxWidth >= AppDimensions.breakpointMobile) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
