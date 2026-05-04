import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/delivery_success_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class DeliverySuccessView extends StatelessWidget {
  const DeliverySuccessView({super.key, required this.order});
  final OrderDelvieryShippingDatum order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(Icons.check_circle_outline, color: Colors.white),
        title: const Text(
          'Delivery Success',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:  DeliverySuccessBody(order: order,),
    );
  }
}
