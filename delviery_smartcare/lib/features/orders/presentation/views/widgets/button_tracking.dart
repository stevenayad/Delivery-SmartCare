import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/datum.dart' show OrderDelvieryShippingDatum;
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/tracking/tracking_cubit_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/final_stage_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/tracking_bottom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonTracking extends StatelessWidget {
  const ButtonTracking({super.key, required this.order});
  final OrderDelvieryShippingDatum order;

  @override
  Widget build(BuildContext context) {
    final isShippingLoading =
        context.watch<OrdersCubit>().state is OrdersLoading;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<TrackingCubit, TrackingState>(
        builder: (context, state) {
          return TrackingBottomCard(
            order: order,
            isArrived: state.phase == TrackingPhase.completed,
            isLoading: isShippingLoading,
            showStoreButton: state.phase == TrackingPhase.toStore &&
                state.remainingDistance < 50,
            onStoreReached: () {
              context
                  .read<OrdersCubit>()
                  .ShippingOrder(order.orderId ?? "");
            },
            onCall: () {},
            onReached: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FinalStageView(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}