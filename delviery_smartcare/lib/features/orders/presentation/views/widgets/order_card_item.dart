import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_action_button.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_Metrics.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_header.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_location.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_title.dart';
import 'package:flutter/material.dart';

class OrderCardItem extends StatelessWidget {
  final OrderDelvieryShippingDatum order;
  final VoidCallback onViewDetails;
  final bool highlighted;

  const OrderCardItem({
    super.key,
    required this.order,
    required this.onViewDetails,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: highlighted 
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardHeader(order: order),
          const SizedBox(height: 8),
          OrderLocation(
            icon: Icons.location_on,
            color: AppColors.primary,
            address: order.storeAddress ?? "",
          ),
          const SizedBox(height: 12),
          OrderLocation(
            icon: Icons.navigation,
            color: Colors.blue,
            address: order.deliveryAddressAdditionalInfo ?? "",
          ),
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
