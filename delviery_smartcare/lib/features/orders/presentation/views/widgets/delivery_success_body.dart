import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/home/presentation/views/live_map_view.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/earnings_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/success_header.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/summary_item_row.dart';
import 'package:delviery_smartcare/presentation/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';

class DeliverySuccessBody extends StatelessWidget {
  const DeliverySuccessBody({super.key, required this.order});
  final OrderDelvieryShippingDatum order;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SuccessHeader(
            title: 'Delivery Complete',
            subtitle: 'Your payout has been added to your balance.',
          ),
          const SizedBox(height: 20),
          EarningsCard(amount: '${order.totalPrice}'),
          SummaryItemRow(
            orderId: order.orderId ?? "",
            deliveryLocation: order.deliveryAddressLine ?? "",
            icon: Icons.medical_services,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => MainScaffold()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 12),
                  Text(
                    'Go Home',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: const Text(
              'VIEW TRANSACTION DETAILS',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
