import 'package:flutter/material.dart';

/// A simplified responsive utility for mobile apps.
///
/// Use this for responsive width, height, font, and padding
/// based on your design's reference screen (e.g., iPhone 16 Pro Max).
class ResponsiveUtils {
  /// Base design dimensions (as per your Figma or designer's reference device)
  static const double baseWidth = 402;
  static const double baseHeight = 874;

  /// Returns responsive width based on screen width
  static double w(BuildContext context, double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (width / baseWidth) * screenWidth;
  }

  /// Returns responsive height based on screen height
  static double h(BuildContext context, double height) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (height / baseHeight) * screenHeight;
  }

  /// Returns responsive font size (based on height)
  static double f(BuildContext context, double fontSize) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (fontSize / baseHeight) * screenHeight;
  }

  /// Returns responsive radius (based on width)
  static double r(BuildContext context, double radius) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (radius / baseWidth) * screenWidth;
  }

  /// Returns responsive padding/margin (based on width)
  static double p(BuildContext context, double value) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (value / baseWidth) * screenWidth;
  }

  /// Check if current device is small, medium, or large
  static bool isSmallDevice(BuildContext context) =>
      MediaQuery.of(context).size.height < 700;

  static bool isLargeDevice(BuildContext context) =>
      MediaQuery.of(context).size.height > 900;
}
