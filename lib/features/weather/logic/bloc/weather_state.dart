part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final String weather;
  WeatherLoaded(this.weather);
}

final class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
