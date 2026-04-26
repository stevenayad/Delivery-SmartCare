import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class Buttonorderdetails extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const Buttonorderdetails({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔸 Decline
          Expanded(
            child: OutlinedButton(
              onPressed: onDecline,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 56),
                side: const BorderSide(color: Color(0xFFD6CBCB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'DECLINE',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    
          const SizedBox(width: 16),
    
          /// 🔸 Accept
          Expanded(
            child: ElevatedButton(
              onPressed: onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'ACCEPT ORDER',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
