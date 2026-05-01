import 'package:bloc/bloc.dart';
import 'package:delviery_smartcare/features/map/data/home_repostioty.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/nearest_store/neareststore_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class NeareststoreCubit extends Cubit<NearestStoreState> {
  NeareststoreCubit({required this.homeRepository}) : super(NearestStoreInitial());

  final HomeRepository homeRepository;

  Future<void> getNearestStore(LatLng userLocation) async {
    emit(NearestStoreLoading());

    final result = await homeRepository.getNearestStore(userLocation);

    result.fold(
      (failure) => emit(NearestStoreFailure(failure)),
      (store) => emit(NearestStoreSuccess(store)),
    );
  }
}
