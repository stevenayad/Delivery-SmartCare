import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/core/widgets/feature_app_bar.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_body_content.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/view_toggle_buttons.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/build_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableOrdersBody extends StatelessWidget {
  const AvailableOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FeatureAppBar(title: 'Available Orders'),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Column(
            children: [
              const ViewToggleButtons(),
              Expanded(
                child: buildBodyContent(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

 
}
