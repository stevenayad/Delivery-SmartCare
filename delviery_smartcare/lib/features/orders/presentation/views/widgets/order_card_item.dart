import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_action_button.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_Metrics.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_header.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_location.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_title.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_model.dart';


class OrderCardItem extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onViewDetails;

  const OrderCardItem({
    super.key,
    required this.order,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardHeader(order: order),
          const SizedBox(height: 8),
          OrderTitle(title: order.title),
          const SizedBox(height: 16),
          OrderLocation(
            icon: Icons.location_on,
            color: AppColors.primary,
            address: order.sourceAddress,
          ),
          if (order.destinationAddress.isNotEmpty) ...[
            const SizedBox(height: 12),
            OrderLocation(
              icon: Icons.navigation,
              color: Colors.blue,
              address: order.destinationAddress,
            ),
          ],
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),
          OrderMetrics(order: order),
          const SizedBox(height: 20),
          OrderActionButton(onPressed: onViewDetails),
        ],
      ),
    );
  }
}