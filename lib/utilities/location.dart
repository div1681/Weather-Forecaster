import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<void> initPermission() async {
    await Geolocator.requestPermission();
  }

  static Future<Position> getLatLon() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
