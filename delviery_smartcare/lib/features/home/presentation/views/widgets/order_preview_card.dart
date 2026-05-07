import 'package:delviery_smartcare/features/home/data/model/store_model.dart';

import 'package:delviery_smartcare/features/home/presentation/views/widgets/action_button_order_preview.dart';
import 'package:delviery_smartcare/features/home/presentation/views/widgets/label_order_preview.dart';
import 'package:delviery_smartcare/features/home/presentation/views/widgets/payout_order_preview.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class OrderPreviewCard extends StatelessWidget {
  final StoreModel store;

  const OrderPreviewCard({super.key, required this.store});

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
                  buildLabel('Nearest Store'),
                  const SizedBox(height: 12),

                  // 👇 اسم الاستور
                  Text(
                    store.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 👇 العنوان + المسافة
          _buildInfoRow(Icons.location_on_outlined, '${store.address} '),

          const SizedBox(height: 8),

          // 👇 رقم التليفون
          _buildInfoRow(Icons.phone, store.phone),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            info,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
