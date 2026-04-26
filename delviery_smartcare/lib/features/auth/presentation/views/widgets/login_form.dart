import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/core/widgets/shared_widgets.dart';
import 'package:delviery_smartcare/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:delviery_smartcare/features/auth/presentation/cubits/auth_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTextField(
          label: 'Email or Phone Number',
          hintText: 'Enter your credentials',
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 24),
        AppTextField(
          label: 'Password',
          hintText: '••••••••',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          suffixIcon: Icon(Icons.visibility_outlined),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return AppButton(
              text: 'Login',
              icon: Icons.arrow_forward,
              isLoading: state is AuthLoading,
              onPressed: () {
                context.read<AuthCubit>().login('email', 'password');
              },
            );
          },
        ),
      ],
    );
  }
}