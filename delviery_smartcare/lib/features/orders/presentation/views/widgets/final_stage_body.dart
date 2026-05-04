import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/data/models/order_delviery_shippinf/order_delviery_datum.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_cubit.dart';
import 'package:delviery_smartcare/features/orders/presentation/cubits/orders/orders_state.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/delivery_success_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/id_verification_row.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_header_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/recipient_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalStageBody extends StatelessWidget {
  const FinalStageBody({super.key, required this.order});
  final OrderDelvieryShippingDatum order;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state.status == OrdersStatus.actionSuccess && 
            state.actionType == OrderActionType.confirm) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DeliverySuccessView(order: order),
            ),
          );
        }

        if (state.status == OrdersStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "Error"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == OrdersStatus.loading;

        return SingleChildScrollView(
          child: Column(
            children: [
              OrderHeaderCard(
                orderId: order.orderId ?? "",
                orderType: 'Priority Pharmacy Delivery',
              ),
              const SizedBox(height: 10),

              RecipientDetailCard(
                name: order.clientName ?? "",
                address: order.deliveryAddressLine ?? "",
                imageUrl: 'https://i.pravatar.cc/150?u=elena',
                itemsCount: order.items?.length.toString() ?? "",
                instruction: 'Hand to Patient',
                onCall: () {},
              ),

              const IDVerificationRow(),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<OrdersCubit>().confirmOrder(
                            order.orderId ?? "",
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 8,
                    shadowColor: AppColors.primary.withOpacity(0.5),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mark as Delivered',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.check_circle_outline, size: 30),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Issue with Delivery?',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
