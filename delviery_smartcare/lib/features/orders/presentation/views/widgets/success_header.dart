import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';


class SuccessHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.online.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check_circle, color: AppColors.online, size: 50),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
