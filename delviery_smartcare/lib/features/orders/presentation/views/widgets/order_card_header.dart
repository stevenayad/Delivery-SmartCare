import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCardHeader extends StatelessWidget {
  final OrderModel order;

  const OrderCardHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ORDER ${order.id}',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: order.isPaid ? AppColors.paid : AppColors.cod,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            order.isPaid ? 'PAID' : 'COD',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}