import 'package:counter_with_theme/core/presentation/localization/generated/l10n.dart';
import 'package:counter_with_theme/features/home/logic/counter_notifier.dart';
import 'package:counter_with_theme/features/weather/presentation/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterNotifier()),
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
