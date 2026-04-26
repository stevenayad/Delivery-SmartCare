import 'package:delviery_smartcare/core/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/cubits/auth_state.dart';
import 'features/map/presentation/cubits/map_cubit.dart';
import 'features/orders/presentation/cubits/orders_cubit.dart';
import 'presentation/widgets/main_scaffold.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => MapCubit()),
        BlocProvider(create: (_) => OrdersCubit()..loadOrders()),
      ],
      child: MaterialApp(
        title: 'Delivery SmartCare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainScaffold()),
          );
        }
      },
      child: const LoginView(),
    );
  }
}
