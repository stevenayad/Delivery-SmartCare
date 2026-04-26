import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButtonsOrderPreview extends StatelessWidget {
final VoidCallback onViewDetails;
  final VoidCallback onClose;

  const ActionButtonsOrderPreview({
    super.key,
    required this.onViewDetails,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onViewDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('View Order Details'),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onClose,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.close, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}