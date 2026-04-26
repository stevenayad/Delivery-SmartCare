 import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_filter_toggle.dart' show OrderFilterToggle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildFilters() {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final activeFilter = state is OrdersLoaded ? state.activeFilter : 'All';
        return OrderFilterToggle(
          activeFilter: activeFilter,
          onFilterChanged: (filter) => context.read<OrdersCubit>().setFilter(filter),
        );
      },
    );
  }