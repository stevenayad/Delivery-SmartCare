import 'package:delviery_smartcare/features/orders/presentation/cubits/tracking/tracking_cubit_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> buildMarkers(TrackingState state) {
    return {
      Marker(
        markerId: const MarkerId('driver'),
        position: state.driverPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
      Marker(markerId: const MarkerId('store'), position: state.store),
      Marker(markerId: const MarkerId('user'), position: state.user),
    };
  }
