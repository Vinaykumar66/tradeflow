// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle h1 = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      letterSpacing: -0.5);
  static const TextStyle h2 = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const TextStyle h3 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 16, color: AppColors.textPrimary, height: 1.5);
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle bodySmall =
      TextStyle(fontSize: 12, color: AppColors.textSecondary);
  static const TextStyle labelLarge = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle labelMedium = TextStyle(
      fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary);
  static const TextStyle labelSmall = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary);
  static const TextStyle amount = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const TextStyle amountLarge = TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary);
}
