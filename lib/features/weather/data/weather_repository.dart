import 'package:counter_with_theme/core/services/location_service/location_service.dart';
import 'package:counter_with_theme/core/services/permission/permission_service.dart';
import 'package:counter_with_theme/core/services/weather_service/weather_service.dart';

abstract class WeatherRepository {
  Future<bool> checkPermission();
  Future<(double, double)> getLocation();
  Future<String> getWeather(double lat, double lng);
}

class WeatherRepositoryImpl implements WeatherRepository {
  final PermissionService permissionService;
  final WeatherService weatherService;
  final LocationService locationService;

  WeatherRepositoryImpl(this.permissionService, this.weatherService, this.locationService);

  @override
  Future<bool> checkPermission() => permissionService.checkPermissionLocation();

  @override
  Future<(double, double)> getLocation() => locationService.getLocation();

  @override
  Future<String> getWeather(double lat, double lng) => weatherService.getWeather(lat, lng);
}
