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
    return weather.toString();
  }
}
