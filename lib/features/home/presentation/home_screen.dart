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
    return Scaffold(
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
        FloatingActionButton(
          heroTag: 'theme',
          onPressed: () {
            context.read<ThemeNotifier>().toggleTheme();
          },
          child: const Icon(Icons.palette),
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
        if (counterNotifier.showAddButton)
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              counterNotifier.add();
            },
            child: const Icon(Icons.add),
          )
        else
          const Hero(
            tag: 'add',
            child: SizedBox(height: 56),
          ),
        const SizedBox(height: 20),
        if (counterNotifier.showRemoveButton)
          FloatingActionButton(
            heroTag: 'remove',
            onPressed: () {
              counterNotifier.remove();
            },
            child: const Icon(Icons.remove),
          )
        else
          const Hero(
            tag: 'remove',
            child: SizedBox(height: 56),
          ),
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
