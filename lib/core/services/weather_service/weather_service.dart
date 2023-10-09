import 'package:counter_with_theme/core/services/weather_service/config.dart';
import 'package:weather/weather.dart';

abstract class WeatherService {
  Future<String> getWeather(double lat, double lng);
}

class WeatherServiceImpl implements WeatherService {
  const WeatherServiceImpl();

  @override
  Future<String> getWeather(double lat, double lng) async {
    WeatherFactory wf = WeatherFactory(WeatherKeys.apiKey);
    Weather? weather = await wf.currentWeatherByLocation(lat, lng);
    final city = weather.areaName ?? '';
    final country = weather.country ?? '';
    final temp = weather.temperature?.celsius?.round() ?? 0;
    final tempF = weather.temperature?.fahrenheit?.round() ?? 0;

    return '$country, $city: $temp°C ($tempF°F)';
  }
}
