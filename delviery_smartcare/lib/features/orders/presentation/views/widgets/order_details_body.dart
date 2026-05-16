import 'package:delviery_smartcare/core/widgets/phone_helper.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/order_status_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/buttons_order_details.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/map_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'customer_request_card.dart';
import 'route_details_widget.dart';
import 'order_summary_card.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderDelvieryShippingDatum order;

  const OrderDetailsBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state.status == OrdersStatus.actionSuccess && 
            state.actionType == OrderActionType.accept) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OrderStatusView(order: order),
            ),
            (route) => false,
          );
        }
        if (state.status == OrdersStatus.error && state.errorType == ErrorType.accepterror) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      child: Stack(
        children: [
          
          const MapBackground(),

    
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      CustomerRequestCard(
                        name: order.clientName ?? "Unknown",
                        label: order.deliveryAddressLabel ?? "Home",
                        rating: "4.9",
                        onCall: () {
                         PhoneHelper.makePhoneCall(order.clientPhone??"");
                        },
                      ),

                      const SizedBox(height: 20),

                    
                      RouteDetailsWidget(
                        storename: order.storeName ?? "",
                        storeAddress: order.storeAddress ?? "",
                        deliveryName: order.deliveryAddressLine ?? "",
                        deliveryAddress:
                            order.deliveryAddressAdditionalInfo ?? "",
                        distancekm: "${order.distanceKm ?? 0} km",
                      ),

                      const SizedBox(height: 20),

                      OrderSummaryCard(
                        items: (order.items ?? [])
                            .map(
                              (e) => {
                                "name": e.medicineName ?? "Unknown",
                                "quantity": "${e.quantity ?? 0}",
                              },
                            )
                            .toList(),
                        medicalPrice:"EGP${order.medicinePrice ?? 0} ",
                        deliveryFee:
                            "EGP${order.deliveryFee ?? 0}",
                        totalPrice: "EGP${order.totalPrice ?? 0}",
                        
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

            
              Buttonorderdetails(
                onAccept: () {
                  context.read<OrdersCubit>().acceptOrder(order.orderId!);
                },
                onDecline: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order Declined')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
