import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_card_item.dart';
import '../order_details_view.dart';


Widget buildOrdersList() {
    return Expanded(
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrdersLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return OrderCardItem(
                  order: state.orders[index],
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailsView(
                        
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: Text('No orders available'));
        },
      ),
    );
  }
