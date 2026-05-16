import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_row_price.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class EarningsCard extends StatelessWidget {
  final String amount;
  final String medicinePrice;
  final String totalPrice;

  const EarningsCard({
    super.key,
    required this.amount,
    required this.medicinePrice,
    required this.totalPrice,
  });

 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          buildPriceRow(
            title: 'Medicine Price',
            value: 'EGP$medicinePrice',
          ),

          const SizedBox(height: 16),

          buildPriceRow(
            title: 'Total Price',
            value: 'EGP$amount',
          ),

          const Divider(height: 32),

          buildPriceRow(
            title: 'Earnings',
            value: 'EGP$totalPrice',
            isEarning: true,
          ),
        ],
      ),
    );
  }
}