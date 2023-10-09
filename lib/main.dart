import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:counter_with_theme/core/presentation/localization/app_localization.dart';
import 'package:counter_with_theme/core/presentation/router/app_router.dart';
import 'package:counter_with_theme/core/presentation/theme/theme_notifier.dart';
import 'package:counter_with_theme/core/services/local_storage_service/local_storage_service.dart';
import 'package:counter_with_theme/core/services/location_service/location_service.dart';
import 'package:counter_with_theme/core/services/permission/permission_service.dart';
import 'package:counter_with_theme/core/services/weather_service/weather_service.dart';
import 'package:counter_with_theme/core/utils/logging/app_bloc_observer.dart';
import 'package:counter_with_theme/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(
    InjectionWidget(
      localStorageService: LocalStorageServiceImpl(),
      locationService: const LocationServiceImpl(),
      permissionService: const PermissionServiceImpl(),
      weatherService: const WeatherServiceImpl(),
      appRouter: AppRouter(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    InjectionWidget.of(context).init().then((value) {
      InjectionWidget.of(context).appRouter.go('/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier(InjectionWidget.of(context).localStorageService)),
        ChangeNotifierProvider(create: (context) => AppLocalization(InjectionWidget.of(context).localStorageService)),
      ],
      builder: (context, _) => ThemeProvider(
        initTheme: context.watch<ThemeNotifier>().isLightTheme ? ThemeData() : ThemeData.dark(),
        builder: (context, data) => MaterialApp.router(
          locale: context.watch<AppLocalization>().locale,
          localizationsDelegates: context.watch<AppLocalization>().localizationsDelegates,
          supportedLocales: context.watch<AppLocalization>().supportedLocales,
          // theme: ThemeData(),
          // darkTheme: ThemeData.dark(),
          // themeMode: context.watch<ThemeNotifier>().isLightTheme ? ThemeMode.light : ThemeMode.dark,
          routerConfig: InjectionWidget.of(context).appRouter,
        ),
      ),
    );
  }
}
