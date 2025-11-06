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
}

class AppDimensions {
  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
}

class AppTextStyles {
  static const TextStyle playfulTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    fontFamily: 'Nunito',
    color: AppColors.textPrimary,
  );
  
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito',
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Nunito',
    color: AppColors.textSecondary,
  );
}