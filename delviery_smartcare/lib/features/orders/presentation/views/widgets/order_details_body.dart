import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/map_background.dart';
import 'package:flutter/material.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderDelvieryShippingDatum order;

  const OrderDetailsBody({super.key, required this.order});

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
                // Order ID
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'Order ID: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(order.orderId ?? ""),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Store Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Store Info',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Address: ${order.storeAddress}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Client Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Client Info',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Name: ${order.clientName}'),
                        Text('Phone: ${order.clientPhone}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Addresses
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Addresses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('From: ${order.storeAddress}'),
                        Text('To: ${order.deliveryAddressAdditionalInfo}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Distance and Price
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Distance: ${order.distanceKm} km'),
                        Text('Total Price: \$${order.totalPrice}'),
                        Text('Delivery Fee: \$${order.deliveryFee}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Items
                if (order.items != null && order.items!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Items',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...order.items!.map(
                            (item) => Text(
                              '${item.medicineName ?? 'Unknown'} - Quantity: ${item.quantity ?? 0}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Accept Order Button
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Accepted!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Accept Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
