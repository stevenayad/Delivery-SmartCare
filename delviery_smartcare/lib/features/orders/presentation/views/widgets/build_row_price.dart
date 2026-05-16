 import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildPriceRow({
    required String title,
    required String value,
    bool isEarning = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isEarning ? 32 : 18,
            fontWeight: FontWeight.bold,
            color: isEarning
                ? AppColors.primary
                : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }