import 'package:delviery_smartcare/features/orders/presentation/cubits/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/avaliable_order_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableOrdersView extends StatefulWidget {
  const AvailableOrdersView({super.key});

  @override
  State<AvailableOrdersView> createState() => _AvailableOrdersViewState();
}

class _AvailableOrdersViewState extends State<AvailableOrdersView> {
  bool _hasLoadedOrders = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedOrders) {
      context.read<OrdersCubit>().loadOrders();
      _hasLoadedOrders = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AvailableOrdersBody();
  }
}
