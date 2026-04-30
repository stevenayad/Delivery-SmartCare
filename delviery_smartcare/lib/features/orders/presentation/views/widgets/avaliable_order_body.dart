import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/core/widgets/feature_app_bar.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_top_section.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableOrdersBody extends StatelessWidget {
  const AvailableOrdersBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FeatureAppBar(title: 'Available Orders'),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// Orders List with states
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OrdersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OrdersCubit>().loadOrders();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is OrdersLoaded) {
                  if (state.orders.isEmpty) {
                    return const Center(child: Text('No orders available'));
                  }

                  return buildOrdersList(state.orders);
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.explore_outlined, color: Colors.white),
      ),
    );
  }
}
