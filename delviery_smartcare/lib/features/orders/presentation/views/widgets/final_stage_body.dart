import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/delivery_success_view.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/id_verification_row.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/order_header_card.dart';
import 'package:delviery_smartcare/features/orders/presentation/views/widgets/recipient_detail_card.dart';
import 'package:flutter/material.dart';

class FinalStageBody extends StatelessWidget {
  const FinalStageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
            const OrderHeaderCard(
              orderId: '#PX-9921',
              orderType: 'Priority Pharmacy Delivery',
            ),
            const SizedBox(height: 10),
            RecipientDetailCard(
              name: 'Mrs. Elena Richardson',
              address: '482 Oakwood Ave, Apt 4C',
              imageUrl: 'https://i.pravatar.cc/150?u=elena',
              itemsCount: '3 Prescriptions',
              instruction: 'Hand to Patient',
              onCall: () {},
            ),
            const IDVerificationRow(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliverySuccessView(),
                    ),
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

                child: const Row(
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
  }
}