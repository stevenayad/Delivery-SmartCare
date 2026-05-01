import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final LatLng currentPosition;
  final Set<Marker> markers;

  MapLoaded({

    required this.currentPosition,
    this.markers = const {},
  });

  MapLoaded copyWith({
    bool? isOnline,
    LatLng? currentPosition,
    Set<Marker>? markers,
  }) {
    return MapLoaded(
      currentPosition: currentPosition ?? this.currentPosition,
      markers: markers ?? this.markers,
    );
  }
}

