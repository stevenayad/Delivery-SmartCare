import 'package:delviery_smartcare/features/orders/presentation/views/order_status_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/tracking_order_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/buttons_order_details.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/customer_request_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/info_box.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/map_background.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_summary_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/route_details_widget.dart';
import 'package:flutter/material.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 🔹 Map Background
        const MapBackground(),

        /// 🔹 Content
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 100),
            child: Column(
              children: [
                CustomerRequestCard(
                  name: 'Mrs. Eleanor Rigby',
                  label: 'Frequent Customer',
                  rating: '4.9',
                  onCall: () {},
                ),
                const SizedBox(height: 30),

                const RouteDetailsWidget(
                  pickupName: 'MediCare Central Pharmacy',
                  pickupAddress: '7th Avenue Medical District, Unit 4B',
                  deliveryName: '404 Lincoln Residential Park',
                  deliveryAddress: 'Apt 12, West Wing Entrance',
                  estTime: '12 mins',
                ),

                const SizedBox(height: 30),

                const OrderSummaryCard(
                  items: [
                    {'name': 'Amoxicillin 500mg', 'quantity': '1'},
                    {'name': 'Lisinopril 10mg (30 day)', 'quantity': '2'},
                    {'name': 'Nitrile Gloves (Box 100)', 'quantity': '1'},
                  ],
                  totalEarnings: '\$18.50',
                ),

                const SizedBox(height: 20),

                const InfoBox(
                  icon: Icons.info_outline,
                  text:
                      'Contains temperature-sensitive medication. Keep in insulated compartment.',
                ),
              ],
            ),
          ),
        ),

        /// 🔹 Bottom Buttons
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Buttonorderdetails(
            onAccept: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderStatusView(),
                ),
              );
            },
            onDecline: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
