import 'package:counter_with_theme/core/presentation/localization/generated/l10n.dart';
import 'package:counter_with_theme/features/weather/logic/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return switch (state) {
          WeatherLoading() => const CircularProgressIndicator(),
          WeatherLoaded() => _Details(state.weather),
          _ => Text(S.of(context).pressTheIconToGetYourLocation),
        };
      },
    );
  }
}

class _Details extends StatelessWidget {
  const _Details(this.details);
  final String details;

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).weatherIn}$details');
  }
}
