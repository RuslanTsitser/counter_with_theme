import 'package:counter_with_theme/core/presentation/router/app_router.dart';
import 'package:counter_with_theme/core/services/local_storage_service/local_storage_service.dart';
import 'package:counter_with_theme/core/services/location_service/location_service.dart';
import 'package:counter_with_theme/core/services/permission/permission_service.dart';
import 'package:counter_with_theme/core/services/weather_service/weather_service.dart';
import 'package:counter_with_theme/injection.dart';
import 'package:flutter/material.dart';

void main() {
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
    return MaterialApp.router(
      routerConfig: InjectionWidget.of(context).appRouter,
    );
  }
}
