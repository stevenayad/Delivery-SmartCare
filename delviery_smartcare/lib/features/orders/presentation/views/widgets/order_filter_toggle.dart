import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class OrderFilterToggle extends StatelessWidget {
  final String activeFilter;
  final Function(String) onFilterChanged;

  const OrderFilterToggle({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildFilterItem(context, 'All'),
          _buildFilterItem(context, 'Nearby'),
          _buildFilterItem(context, 'High Price'),
        ],
      ),
    );
  }

  Widget _buildFilterItem(BuildContext context, String filter) {
    final isActive = activeFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive ? AppColors.softShadow : null,
          ),
          child: Text(
            filter,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.grey[600],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
