import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? "),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Contact Admin',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/medical_background.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          '© 2024 Delivery Portal. Clinical Excellence in Logistics.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}