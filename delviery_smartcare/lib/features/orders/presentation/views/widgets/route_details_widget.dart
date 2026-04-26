import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class RouteDetailsWidget extends StatelessWidget {
  final String pickupName;
  final String pickupAddress;
  final String deliveryName;
  final String deliveryAddress;
  final String estTime;

  const RouteDetailsWidget({
    super.key,
    required this.pickupName,
    required this.pickupAddress,
    required this.deliveryName,
    required this.deliveryAddress,
    required this.estTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ROUTE DETAILS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Est. $estTime',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            children: [
              _buildRoutePoint(
                icon: Icons.add_business_rounded,
                iconColor: AppColors.primary,
                label: 'PICKUP',
                title: pickupName,
                subtitle: pickupAddress,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      width: 2,
                      height: 4,
                      color: AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              _buildRoutePoint(
                icon: Icons.location_on,
                iconColor: AppColors.primary,
                label: 'DELIVERY',
                title: deliveryName,
                subtitle: deliveryAddress,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoutePoint({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
