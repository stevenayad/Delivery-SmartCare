
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_item.dart';
import 'package:flutter/material.dart';
import '../order_details_view.dart';
Widget buildOrdersList(List<OrderDelvieryShippingDatum> orders) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: orders.length,
    itemBuilder: (context, index) {
      final order = orders[index];
      return OrderCardItem(
        order: order,
        onViewDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsView(order: order),
            ),
          );
        },
      );
    },
  );
}