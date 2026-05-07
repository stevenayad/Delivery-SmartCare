import 'package:delviery_smartcare/core/servieces/location_serviecs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Future<void> initializeMap() async {
    emit(MapLoading());
    try {
      final position = await LocationServices.getlocationData();
      final latLng = LatLng(position.latitude!, position.longitude!);
      print("latitude: ${position.latitude}, longitude: ${position.longitude}");
      final markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'My Location'),
        ),
      };

      emit(MapLoaded(currentPosition: latLng, markers: markers));
    } catch (e) {
      // Fallback to a default location if permission denied or error
      const defaultLatLng = LatLng(37.42796133580664, -122.085749655962);
      emit(
        MapLoaded(
          currentPosition: defaultLatLng,
          markers: {
            const Marker(
              markerId: MarkerId('default_location'),
              position: defaultLatLng,
            ),
          },
        ),
      );
    }
  }

  
}
