import 'package:delviery_smartcare/features/orders/presentation/views/widgets/final_stage_body.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'delivery_success_view.dart';
import 'widgets/order_header_card.dart';
import 'widgets/recipient_detail_card.dart';
import 'widgets/id_verification_row.dart';

class FinalStageView extends StatelessWidget {
  const FinalStageView({super.key});

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
      body: const FinalStageBody(),
    );
  }
}
