import 'package:delviery_smartcare/core/apiservices/api_service.dart';
import 'package:delviery_smartcare/features/home/data/home_repostioty.dart';
import 'package:delviery_smartcare/features/home/presentation/cubits/nearest_store/neareststore_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:delviery_smartcare/features/home/presentation/views/widgets/live_map_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveMapView extends StatelessWidget {
  const LiveMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NeareststoreCubit(homeRepository: HomeRepository(apiService: ApiService(Dio()))),
      child: const Scaffold(body: LiveMapBody()),
    );
  }
}
