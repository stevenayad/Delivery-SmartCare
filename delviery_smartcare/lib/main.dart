import 'package:delviery_smartcare/core/bloc_observer.dart';
import 'package:delviery_smartcare/core/apiservices/api_service.dart';
import 'package:delviery_smartcare/core/apiservices/token_storage_service.dart';
import 'package:delviery_smartcare/features/auth/data/repositories/auth_repository.dart';
import 'package:delviery_smartcare/features/orders/data/repository/oeder_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    final tokenStorage = TokenStorageService(FlutterSecureStorage());
    final apiService = ApiService(tokenStorage: tokenStorage);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            authRepository: AuthRepository(
              apiService: apiService,
              tokenStorage: tokenStorage,
            ),
          ),
        ),
        BlocProvider(create: (_) => MapCubit()),
        BlocProvider(
          create: (_) =>
              OrdersCubit(OrderRepositoryImpl(apiService: apiService)),
        ),
      ],
      child: MaterialApp(
        title: 'Delivery SmartCare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AppRoot(),
      ),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (!context.mounted) return;

        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<AuthCubit>()),
                  BlocProvider.value(value: context.read<OrdersCubit>()),
                  BlocProvider.value(value: context.read<MapCubit>()),
                ],
                child: const MainScaffold(),
              ),
            ),
          );
        }
      },
      child: const LoginView(),
    );
  }
}
