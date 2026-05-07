import 'package:delviery_smartcare/core/servieces/faliure_services.dart';
import 'package:delviery_smartcare/features/home/data/model/store_model.dart';


abstract class NearestStoreState {}

class NearestStoreInitial extends NearestStoreState {}

class NearestStoreLoading extends NearestStoreState {}

class NearestStoreSuccess extends NearestStoreState {
  final StoreModel store;

  NearestStoreSuccess(this.store);
}

class NearestStoreFailure extends NearestStoreState {
  final Failure failure;

  NearestStoreFailure(this.failure);
}