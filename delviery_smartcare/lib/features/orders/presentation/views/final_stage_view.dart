import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/final_stage_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';


class FinalStageView extends StatelessWidget {
  const FinalStageView({super.key, required this.order});
  final OrderDelvieryShippingDatum order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'FINAL STAGE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:  FinalStageBody(order: order,),
    );
  }
}
