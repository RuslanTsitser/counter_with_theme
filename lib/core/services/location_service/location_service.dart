import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<(double lat, double lng)> getLocation();
}

class LocationServiceImpl implements LocationService {
  const LocationServiceImpl();
  @override
  Future<(double, double)> getLocation() async {
    final location = await Geolocator.getCurrentPosition();
    return (location.latitude, location.longitude);
  }
}
