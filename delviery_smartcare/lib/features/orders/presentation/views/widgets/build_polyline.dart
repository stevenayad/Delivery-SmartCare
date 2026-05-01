
  import 'package:delviery_smartcare/features/orders/presentation/cubits/tracking/tracking_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Polyline> buildPolylines(TrackingState state) {
    LatLng target = state.phase == TrackingPhase.toStore
        ? state.store
        : state.user;

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [state.driverPosition, target],
        color: Colors.blue,
        width: 5,
      ),
    };
  }