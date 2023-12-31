import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:counter_with_theme/core/presentation/localization/generated/l10n.dart';
import 'package:counter_with_theme/core/presentation/theme/theme_notifier.dart';
import 'package:counter_with_theme/features/home/logic/counter_notifier.dart';
import 'package:counter_with_theme/features/weather/data/weather_repository.dart';
import 'package:counter_with_theme/features/weather/logic/bloc/weather_bloc.dart';
import 'package:counter_with_theme/features/weather/presentation/weather_widget.dart';
import 'package:counter_with_theme/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
            create: (context) => WeatherRepositoryImpl(
                  InjectionWidget.of(context).permissionService,
                  InjectionWidget.of(context).weatherService,
                  InjectionWidget.of(context).locationService,
                )),
        ChangeNotifierProvider(create: (_) => CounterNotifier()),
        BlocProvider(
          create: (context) => WeatherBloc(
            context.read<WeatherRepository>(),
          ),
        ),
      ],
      child: const HomeScreenMain(),
    );
  }
}

class HomeScreenMain extends StatelessWidget {
  const HomeScreenMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).weatherCounter),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherWidget(),
              SizedBox(height: 20),
              _CounterWidget(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const _Buttons(),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        _OtherButtons(),
        Spacer(),
        _CounterButtons(),
        SizedBox(width: 16),
      ],
    );
  }
}

class _OtherButtons extends StatelessWidget {
  const _OtherButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'weather',
          onPressed: () {
            context.read<WeatherBloc>().add(GetWeatherEvent());
          },
          child: const Icon(Icons.cloud),
        ),
        const SizedBox(height: 20),
        ThemeSwitcher(
          builder: (context) => FloatingActionButton(
            heroTag: 'theme',
            onPressed: () {
              context.read<ThemeNotifier>().toggleTheme().then((value) => ThemeSwitcher.of(context).changeTheme(
                    theme: context.read<ThemeNotifier>().isLightTheme ? ThemeData() : ThemeData.dark(),
                  ));
            },
            child: const Icon(Icons.palette),
          ),
        )
      ],
    );
  }
}

class _CounterButtons extends StatelessWidget {
  const _CounterButtons();

  @override
  Widget build(BuildContext context) {
    final CounterNotifier counterNotifier = context.watch<CounterNotifier>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: counterNotifier.showAddButton ? 1 : 0,
            child: FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                counterNotifier.add(!context.read<ThemeNotifier>().isLightTheme);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 56,
          width: 56,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: counterNotifier.showRemoveButton ? 1 : 0,
            child: FloatingActionButton(
              heroTag: 'remove',
              onPressed: () {
                counterNotifier.remove(!context.read<ThemeNotifier>().isLightTheme);
              },
              child: const Icon(Icons.remove),
            ),
          ),
        )
      ],
    );
  }
}

class _CounterWidget extends StatelessWidget {
  const _CounterWidget();

  @override
  Widget build(BuildContext context) {
    final counterNotifier = context.watch<CounterNotifier>();
    return Column(
      children: [
        Text(S.of(context).youHavePushedTheButtonThisManyTimes),
        Text(
          counterNotifier.counter.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
