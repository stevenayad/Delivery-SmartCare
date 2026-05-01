import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreModel {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'],
    );
  }

  LatLng get latLng => LatLng(latitude, longitude);
}