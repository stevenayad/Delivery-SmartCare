import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OrderActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View Details'),
            SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}