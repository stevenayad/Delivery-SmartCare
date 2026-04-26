import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class ActionBottomArea extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final String estimatedTime;
  final VoidCallback onPressed;

  const ActionBottomArea({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.estimatedTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: AppColors.primary.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(buttonIcon),
                const SizedBox(width: 10),
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Estimated completion time: $estimatedTime',
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
