import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingService {
  
  static const LatLng target = LatLng(31.093327568709306, 29.76168021020216);

  static const int _totalSteps = 60;

  static const Duration _interval = Duration(seconds: 1);

  static LatLng get startPosition =>
      LatLng(target.latitude + (1000 / 111000), target.longitude);

  Stream<LatLng> simulateMovement(LatLng start, LatLng target) {
    int step = 0;
    late StreamController<LatLng> controller;

    Timer? timer;

    controller = StreamController<LatLng>(
      onListen: () {
        controller.add(start);

        timer = Timer.periodic(_interval, (_) {
          step++;

          final double t = step / _totalSteps;
          final LatLng current = _lerpLatLng(start, target, t);
          controller.add(current);
          final double dist = haversineDistance(current, target);
          if (step >= _totalSteps || dist < 5.0) {
            timer?.cancel();
            controller.close();
          }
        });
      },
      onCancel: () {
        timer?.cancel();
      },
    );

    return controller.stream;
  }

  static LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(
      a.latitude + (b.latitude - a.latitude) * t,
      a.longitude + (b.longitude - a.longitude) * t,
    );
  }

  static double haversineDistance(LatLng a, LatLng b) {
    const double earthRadius = 6371000; 
    final double dLat = _toRad(b.latitude - a.latitude);
    final double dLon = _toRad(b.longitude - a.longitude);

    final double sinDLat = sin(dLat / 2);
    final double sinDLon = sin(dLon / 2);

    final double h =
        sinDLat * sinDLat +
        cos(_toRad(a.latitude)) * cos(_toRad(b.latitude)) * sinDLon * sinDLon;

    return 2 * earthRadius * asin(sqrt(h));
  }

  static double _toRad(double degrees) => degrees * pi / 180;
}