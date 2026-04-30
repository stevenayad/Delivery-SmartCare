import 'package:delviery_smartcare/core/theme/app_colors.dart';
import 'package:delviery_smartcare/core/widgets/shared_widgets.dart';
import 'package:delviery_smartcare/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:delviery_smartcare/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (!context.mounted) return;

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Column(
        children: [
          AppTextField(
            controller: cubit.emailController,
            label: 'Email or Phone Number',
            hintText: 'Enter your credentials',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 24),

          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppTextField(
                controller: cubit.passwordController,
                label: 'Password',
                hintText: '••••••••',
                prefixIcon: Icons.lock_outline,
                isPassword: !cubit.isPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: cubit.togglePasswordVisibility,
                  child: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                  ),
                ),
              );
            },
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
                onPressed: cubit.login,
              );
            },
          ),
        ],
      ),
    );
  }
}
