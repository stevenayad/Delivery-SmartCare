import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:delviery_smartcare/core/apiservices/api_service.dart';
import 'package:delviery_smartcare/core/servieces/faliure_services.dart';
import 'package:delviery_smartcare/core/servieces/tracking_services.dart';
import 'package:delviery_smartcare/features/home/data/model/store_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository({required this.apiService});

  Future<Either<Failure, StoreModel>> getNearestStore(
    LatLng userLocation,
  ) async {
    try {
      final data = await apiService.get('/api/stores');

      final List stores = data['data'];

      double minDistance = double.infinity;
      StoreModel? nearestStore;

      for (var s in stores) {
        final store = StoreModel.fromJson(s);

        final distance = calculateDistance(userLocation, store.latLng);

        if (distance < minDistance) {
          minDistance = distance;
          nearestStore = store;
        }
      }

      if (nearestStore == null) {
        return Left(ServiveFailure('No stores found'));
      }

      return Right(nearestStore);
    } catch (e) {
      return Left(ServiveFailure(e.toString()));
    }
  }
}
