import 'package:flutter/material.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';

class OrderMetrics extends StatelessWidget {
  final order;

  const OrderMetrics({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OrderMetric(label: 'DISTANCE', value: '${order.distanceKm?.toString() ?? '0'} km'),
        const SizedBox(width: 24),
        OrderMetric(label: 'ETA', value: '--'),
        const Spacer(),
        OrderMetric(label: 'EARNING', value: '\$${order.deliveryFee?.toString() ?? '0'}', isHighlight: true),
      ],
    );
  }
}

class OrderMetric extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const OrderMetric({
    super.key,
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isHighlight ? AppColors.primary : Colors.black87,
          ),
        ),
      ],
    );
  }
}
