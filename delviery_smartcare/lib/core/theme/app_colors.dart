import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFB71C1C);
  static const Color secondary = Color(0xFFB71C1C);
  
  // Background colors
  static const Color background = Color(0xFFF9F9F9);
  static const Color cardBackground = Colors.white;
  static const Color scaffoldBackground = Color(0xFFFDECEE); // Light red/pinkish tint
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;
  
  // Input field colors
  static const Color inputFill = Color(0xFFFFEBEE);
  static const Color inputBorder = Color(0xFFFFCDD2);
  
  // Status colors
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF1976D2);
  static const Color warning = Color(0xFFFFA000);
  
  // Accents
  static const Color online = Color(0xFF21C064);
  static const Color paid = Color(0xFF388E3C);
  static const Color cod = Color(0xFFFFA000);
  
  // Shadows
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
}
