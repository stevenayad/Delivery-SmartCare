import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_filters.dart'
    show buildFilters;
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import '../../../../core/widgets/feature_app_bar.dart';
import '../cubits/orders_cubit.dart';
import '../cubits/orders_state.dart';

import 'widgets/order_filter_toggle.dart';
import 'widgets/order_card_item.dart';

class AvailableOrdersView extends StatelessWidget {
  const AvailableOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FeatureAppBar(title: 'Available Orders'),
      body: Column(
        children: [
          const SizedBox(height: 16),
          buildFilters(),
          const SizedBox(height: 16),
          buildOrdersList(),
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
