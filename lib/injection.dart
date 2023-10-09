import 'package:counter_with_theme/core/services/local_storage_service/local_storage_service.dart';
import 'package:counter_with_theme/core/services/location_service/location_service.dart';
import 'package:counter_with_theme/core/services/permission/permission_service.dart';
import 'package:counter_with_theme/core/services/weather_service/weather_service.dart';
import 'package:flutter/material.dart';

class InjectionWidget extends InheritedWidget {
  final LocalStorageService localStorageService;
  final LocationService locationService;
  final PermissionService permissionService;
  final WeatherService weatherService;
  const InjectionWidget({
    super.key,
    required this.localStorageService,
    required this.locationService,
    required this.permissionService,
    required this.weatherService,
    required super.child,
  });

  static InjectionWidget? of(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<InjectionWidget>()
      : context.findAncestorWidgetOfExactType<InjectionWidget>();

  @override
  bool updateShouldNotify(InjectionWidget oldWidget) {
    return true;
  }
}
