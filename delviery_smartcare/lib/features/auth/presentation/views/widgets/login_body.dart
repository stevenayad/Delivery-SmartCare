import 'package:delviery_smartcare/features/auth/presentation/views/widgets/login_footer.dart';
import 'package:delviery_smartcare/features/auth/presentation/views/widgets/login_form.dart';
import 'package:delviery_smartcare/features/auth/presentation/views/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  LoginHeader(),
                  SizedBox(height: 40),
                  LoginForm(),
                  SizedBox(height: 40),
                  LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}