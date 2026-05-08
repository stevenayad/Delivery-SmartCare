 import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildBodyContent(BuildContext context, OrdersState state) {
    if (state.status == OrdersStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == OrdersStatus.error && state.errorType == ErrorType.loaderror) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage ?? 'Something went wrong'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  context.read<OrdersCubit>().loadOrders();
                },
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      );
    }

    if (state.orders.isEmpty) {
      return const Center(child: Text('No orders available'));
    }

    return buildOrdersList(
      state.orders,
      isNearest: state.viewType == OrdersViewType.nearest || state.viewType == OrdersViewType.smart,
    );
  }