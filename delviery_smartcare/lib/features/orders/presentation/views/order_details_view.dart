import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_details_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderDelvieryShippingDatum order;

  const OrderDetailsView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: OrderDetailsBody(order: order),
    );
  }
}
