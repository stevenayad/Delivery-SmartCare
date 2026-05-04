import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/tracking_order_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/action_bottom_area.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_main_details_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/prescription_details_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/success_header.dart';
import 'package:flutter/material.dart';

class OrderStatusBody extends StatelessWidget {
  const OrderStatusBody({super.key, required this.order});
  final OrderDelvieryShippingDatum order;
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
            orderId: order.orderId ?? "",
            pickupName: order.storeName ?? "",
            pickupAddress: order.storeAddress ?? "",
            deliveryName: order.deliveryAddressLine ?? "",
            deliveryAddress: order.deliveryAddressAdditionalInfo ?? "",
            mapImagePath: 'assets/images/map_route.png',
          ),

          PrescriptionDetailsCard(
            items: order.items!.map((e) {
              return {
                'name': e.medicineName ?? 'Unknown',
                'quantity': (e.quantity ?? 0).toString(),
              };
            }).toList(),
          ),

          const SizedBox(height: 20),
          ActionBottomArea(
            buttonText: 'START PICKUP',
            buttonIcon: Icons.directions_car,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  TrackingOrderView(order: order,),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
