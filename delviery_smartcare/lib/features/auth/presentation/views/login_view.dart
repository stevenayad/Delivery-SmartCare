import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/core/widgets/feature_app_bar.dart';
import 'package:delviery_smartcare/features/auth/presentation/views/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const FeatureAppBar(title: 'Welcome'),
      body: const LoginBody(),
    );
  }
}