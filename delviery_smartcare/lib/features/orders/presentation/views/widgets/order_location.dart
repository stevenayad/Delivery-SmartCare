import 'package:flutter/material.dart';

class OrderLocation extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String address;

  const OrderLocation({
    super.key,
    required this.icon,
    required this.color,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            address,
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
        ),
      ],
    );
  }
}