import 'package:delviery_smartcare/features/orders/presentation/views/tracking_order_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/action_bottom_area.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_main_details_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/prescription_details_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/success_header.dart';
import 'package:flutter/material.dart';

class OrderStatusBody extends StatelessWidget {
  const OrderStatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            const SuccessHeader(
              title: 'Order Accepted',
              subtitle: 'Your delivery task is now active',
            ),
            OrderMainDetailsCard(
              orderId: '#RX-992104',
              pickupName: 'Central Pharmacy',
              pickupAddress: '1200 Medical Center Way',
              deliveryName: 'Sarah Johnson',
              deliveryAddress: '452 Oak Ridge Dr.',
              mapImagePath: 'assets/images/map_route.png',
            ),
            const PrescriptionDetailsCard(
              items: [
                {'name': 'Lisinopril 10mg (30ct)', 'quantity': '2'},
                {'name': 'Metformin 500mg (60ct)', 'quantity': '1'},
              ],
            ),
            const SizedBox(height: 20),
            ActionBottomArea(
              buttonText: 'START PICKUP',
              buttonIcon: Icons.directions_car,
              estimatedTime: '24 mins',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrackingOrderView(
                  
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
  }
}