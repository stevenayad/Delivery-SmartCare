import 'package:delviery_smartcare/features/map/presentation/cubits/nearest_store/neareststore_cubit.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/nearest_store/neareststore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_init/map_cubit.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_init/map_state.dart';

class MapViewWidget extends StatelessWidget {
  const MapViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLoaded) {
          context.read<NeareststoreCubit>().getNearestStore(
            state.currentPosition,
          );
        }
      },
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MapLoaded) {
            return BlocBuilder<NeareststoreCubit, NearestStoreState>(
              builder: (context, nearestState) {
                Set<Marker> markers = {...state.markers};
                Set<Polyline> ployine = {};
                if (nearestState is NearestStoreSuccess) {
                  final store = nearestState.store;
                  markers.add(
                    Marker(
                      markerId: MarkerId(store.id),
                      position: store.latLng,
                      infoWindow: InfoWindow(title: store.name),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                  );
                  final polyline = Polyline(
                    polylineId: const PolylineId('route'),
                    points: [state.currentPosition, store.latLng],
                    width: 5,
                    color: Colors.blue,
                  );
                  ployine.add(polyline);
                }

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.currentPosition,
                    zoom: 14,
                  ),
                  markers: markers,
                  polylines: ployine,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                );
              },
            );
          }

          return const Center(child: Text('Failed to load map'));
        },
      ),
    );
  }
}
