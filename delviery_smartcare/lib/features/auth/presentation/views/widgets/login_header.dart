import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppColors.softShadow,
          ),
          child: const Icon(
            Icons.medical_services,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 8),
        Text(
          'Login to manage your medical orders',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}