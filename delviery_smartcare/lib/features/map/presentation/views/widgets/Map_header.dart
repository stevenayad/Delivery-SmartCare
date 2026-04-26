import 'package:delviery_smartcare/core/theme/app_colors.dart';

import 'package:flutter/material.dart';

class MapHeader extends StatelessWidget {
  const MapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppColors.softShadow,
        ),
        child: Row(
          children: [
            const Icon(Icons.menu),
            const SizedBox(width: 12),
            const Text(
              'Live Map',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
