import 'package:bloc/bloc.dart';
import 'package:counter_with_theme/core/utils/logging/app_logger.dart';
import 'package:counter_with_theme/features/weather/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) => switch (event) {
          GetWeatherEvent() => _getWeather(emit),
        });
  }

  Future<void> _getWeather(Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final granted = await _weatherRepository.checkPermission();
      if (granted) {
        final location = await _weatherRepository.getLocation();
        final weather = await _weatherRepository.getWeather(location.$1, location.$2);
        emit(WeatherLoaded(weather));
      } else {
        logErrorBlOC('Permission denied');

        emit(WeatherError('Permission denied'));
      }
    } catch (e) {
      logErrorBlOC(e.toString());
      emit(WeatherError(e.toString()));
    }
  }
}
