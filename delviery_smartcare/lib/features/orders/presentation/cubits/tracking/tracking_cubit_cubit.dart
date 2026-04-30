import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:delviery_smartcare/core/servieces/tracking_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingService service;
  StreamSubscription? sub;

  TrackingCubit(this.service)
      : super(
          TrackingState(
            driverPosition: const LatLng(0, 0),
            store: const LatLng(0, 0),
            user: const LatLng(0, 0),
            phase: TrackingPhase.toStore,
            remainingDistance: 0,
          ),
        );

  void initialize({
    required double driverLat,
    required double driverLng,
    required double storeLat,
    required double storeLng,
    required double userLat,
    required double userLng,
  }) {
    final driverPos = LatLng(driverLat, driverLng);
    final storePos = LatLng(storeLat, storeLng);
    final userPos = LatLng(userLat, userLng);

    emit(state.copyWith(
      driverPosition: driverPos,
      store: storePos,
      user: userPos,
      phase: TrackingPhase.toStore,
      remainingDistance:
          TrackingService.haversineDistance(driverPos, storePos),
    ));

    _moveTo(storePos);
  }

  void _moveTo(LatLng target, {LatLng? startFrom}) {
    sub?.cancel();

    final startPosition = startFrom ?? state.driverPosition;

    sub = service
        .simulateMovement(startPosition, target)
        .listen((pos) {
      final dist =
          TrackingService.haversineDistance(pos, target);

      emit(state.copyWith(
        driverPosition: pos,
        remainingDistance: dist,
      ));

      if (dist < 5) {
        if (state.phase == TrackingPhase.toStore) {
          sub?.cancel();
        } else if (state.phase == TrackingPhase.toUser) {
          emit(state.copyWith(phase: TrackingPhase.completed));
          sub?.cancel();
        }
      }
    });
  }


  void moveToUser() {
    emit(state.copyWith(
      phase: TrackingPhase.toUser,
      remainingDistance: TrackingService.haversineDistance(
        state.driverPosition,
        state.user,
      ),
    ));

    _moveTo(
      state.user,
      startFrom: state.driverPosition,
    );
  }

  @override
  Future<void> close() {
    sub?.cancel();
    return super.close();
  }
}