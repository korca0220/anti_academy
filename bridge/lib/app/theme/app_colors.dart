import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color secondary = Color(0xFF10B981); // Emerald 500
  static const Color accent = Color(0xFFF59E0B); // Amber 500

  // Neutral Colors
  static const Color textPrimary = Color(0xFF1F2937); // Gray 800
  static const Color textSecondary = Color(0xFF6B7280); // Gray 500
  static const Color textTertiary = Color(0xFF9CA3AF); // Gray 400
  static const Color background = Color(0xFFF9FAFB); // Gray 50
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE5E7EB); // Gray 200

  // Semantic Colors
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color info = Color(0xFF3B82F6); // Blue 500
}
