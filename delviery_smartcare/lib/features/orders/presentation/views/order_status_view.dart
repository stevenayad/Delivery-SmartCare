import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_status_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'tracking_order_view.dart';
import 'widgets/success_header.dart';
import 'widgets/order_main_details_card.dart';
import 'widgets/prescription_details_card.dart';
import 'widgets/action_bottom_area.dart';

class OrderStatusView extends StatelessWidget {
 

  const OrderStatusView({super.key});

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
          'Order Status',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const OrderStatusBody()
    );
  }
}
