import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00C853);
  static const Color secondary = Color(0xFF69F0AE);
  static const Color accent = Color(0xFFFF6D00);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE0E0E0);
}

class AppDimensions {
  // Responsive padding based on screen size
  static double getSmallPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 6.0 : 8.0;
  }

  static double getMediumPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 12.0 : 16.0;
  }

  static double getLargePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 16.0 : 24.0;
  }

  // Responsive font sizes
  static double getTitleFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 28.0 : 32.0;
  }

  static double getSubtitleFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 18.0 : 20.0;
  }

  static double getBodyFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 14.0 : 16.0;
  }

  // Responsive card dimensions
  static double getCardRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 12.0 : 16.0;
  }

  static double getButtonRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 360 ? 10.0 : 12.0;
  }

  // Grid layout responsive
  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 400) return 2;
    if (width < 600) return 3;
    if (width < 900) return 4;
    return 5;
  }

  static double getGridChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 400 ? 0.9 : 1.5;
  }
}

class AppTextStyles {
  static TextStyle playfulTitle(BuildContext context) => TextStyle(
    fontSize: AppDimensions.getTitleFontSize(context),
    fontWeight: FontWeight.w800,
    fontFamily: 'Nunito',
    color: AppColors.textPrimary,
  );
  
  static TextStyle cardTitle(BuildContext context) => TextStyle(
    fontSize: AppDimensions.getBodyFontSize(context),
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito',
    color: AppColors.textPrimary,
  );
  
  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: AppDimensions.getBodyFontSize(context) - 2,
    fontWeight: FontWeight.w500,
    fontFamily: 'Nunito',
    color: AppColors.textSecondary,
  );
}