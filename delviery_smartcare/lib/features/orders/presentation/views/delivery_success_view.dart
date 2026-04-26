import 'package:delviery_smartcare/features/orders/presentation/views/widgets/delivery_success_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'widgets/success_header.dart';
import 'widgets/earnings_card.dart';
import 'widgets/summary_item_row.dart';

class DeliverySuccessView extends StatelessWidget {
  const DeliverySuccessView({super.key});

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
      body: const DeliverySuccessBody(),
    );
  }
}
