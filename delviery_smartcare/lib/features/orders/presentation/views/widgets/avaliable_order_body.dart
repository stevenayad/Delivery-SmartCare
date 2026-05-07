import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_body_content.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/view_toggle_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableOrdersBody extends StatelessWidget {
  const AvailableOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Column(
          children: [
            const ViewToggleButtons(),
            Expanded(child: buildBodyContent(context, state)),
          ],
        );
      },
    );
  }
}
