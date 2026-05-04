import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ViewToggleButtons extends StatelessWidget {
  const ViewToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: ToggleButton(
                  label: 'All Orders',
                  isSelected: state.viewType == OrdersViewType.normal,
                  onPressed: () => context.read<OrdersCubit>().changeView(OrdersViewType.normal),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ToggleButton(
                  label: 'Nearest',
                  isSelected: state.viewType == OrdersViewType.nearest,
                  onPressed: () => context.read<OrdersCubit>().changeView(OrdersViewType.nearest),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ToggleButton(
                  label: 'Smart',
                  isSelected: state.viewType == OrdersViewType.smart,
                  onPressed: () => context.read<OrdersCubit>().changeView(OrdersViewType.smart),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
