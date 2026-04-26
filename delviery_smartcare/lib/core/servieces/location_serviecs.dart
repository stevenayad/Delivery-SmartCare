import 'package:location/location.dart';

class LocationServices {
  static Location location = Location();

 static Future<bool> CheckAndRequestLocationServices() async {
    var ServiceEnbled = await location.serviceEnabled();
    if (!ServiceEnbled) {
      bool ServiceEnbled = await location.requestService();
      if (!ServiceEnbled) {
        return false;
      }
    }
    return true;
  }

  static Future<bool> CheckAndRequestLocationPermission() async {
    var permsissionStatus = await location.hasPermission();

    if (permsissionStatus == PermissionStatus.deniedForever) {
      return false;
    }

    if (permsissionStatus == PermissionStatus.denied) {
      var permsissionStatus = await location.requestPermission();
      return (permsissionStatus == PermissionStatus.granted);
    }
    return true;
  }

  static Future<LocationData> getlocationData() async {
    CheckAndRequestLocationServices();
    CheckAndRequestLocationPermission();
    return await location.getLocation();
  }
}
