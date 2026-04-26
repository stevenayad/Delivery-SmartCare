import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_details_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';


class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

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
      body: const OrderDetailsBody()
    );
  }
}
