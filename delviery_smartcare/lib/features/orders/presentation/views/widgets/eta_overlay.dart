import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class ETAOverlay extends StatelessWidget {
  final String eta;
  final String distanceRemaining;

  const ETAOverlay({
    super.key,
    required this.eta,
    required this.distanceRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ETA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            eta,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            distanceRemaining,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
