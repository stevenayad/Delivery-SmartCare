import 'package:delviery_smartcare/features/map/presentation/views/widgets/action_button_order_preview.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/label_order_preview.dart';
import 'package:delviery_smartcare/features/map/presentation/views/widgets/payout_order_preview.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class OrderPreviewCard extends StatelessWidget {
  final String title;
  final String payout;
  final String distanceInfo;
  final VoidCallback onViewDetails;
  final VoidCallback onClose;

  const OrderPreviewCard({
    super.key,
    required this.title,
    required this.payout,
    required this.distanceInfo,
    required this.onViewDetails,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel('IMMEDIATE DELIVERY'),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              PayoutOrderPreview(payout: payout,),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.medical_services_outlined, distanceInfo),
          const SizedBox(height: 24),
          ActionButtonsOrderPreview(onViewDetails:onViewDetails, onClose: onClose,),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(info, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      ],
    );
  }
}
