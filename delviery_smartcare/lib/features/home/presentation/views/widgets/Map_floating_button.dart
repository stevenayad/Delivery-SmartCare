import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MapFloatingButtons extends StatelessWidget {
  const MapFloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 120,
      child: Column(
        children: const [
          _FloatingButton(icon: Icons.layers),
        ],
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final IconData icon;

  const _FloatingButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.softShadow,
      ),
      child: Icon(icon, color: Colors.black87, size: 20),
    );
  }
}