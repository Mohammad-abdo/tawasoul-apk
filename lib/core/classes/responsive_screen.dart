import 'package:flutter/material.dart';

class ResponsiveScreen {
  static late double height;
  static late double width;

  static void initialize(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}

/// Breakpoints ثابتة
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

/// Responsive Helper
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppBreakpoints.mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppBreakpoints.mobile &&
      MediaQuery.of(context).size.width < AppBreakpoints.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppBreakpoints.tablet;
}
