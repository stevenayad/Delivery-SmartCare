import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_cubit.dart';
import 'package:delviery_smartcare/features/map/presentation/cubits/map_state.dart';

class MapViewWidget extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;

  const MapViewWidget({super.key, required this.onMapCreated});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MapLoaded) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: state.currentPosition,
              zoom: 16,
            ),
            onMapCreated: onMapCreated,
            markers: state.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: const EdgeInsets.only(top: 100),
          );
        }

        return const Center(child: Text('Failed to load map'));
      },
    );
  }
}
