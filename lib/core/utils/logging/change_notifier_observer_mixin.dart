import 'package:flutter/material.dart';

import 'app_logger.dart';

mixin ChangeNotifierObserverMixin on ChangeNotifier {
  Map<String, dynamic> get properties;

  bool get enableLogs => true;

  @override
  void notifyListeners() {
    if (enableLogs) {
      final propertiesString = properties.entries.map((e) => '${e.key} : ${e.value}').toList().join("\n");
      final data = '$runtimeType\n$propertiesString';
      logChangeNotifier(data);
    }

    super.notifyListeners();
  }

  @override
  void dispose() {
    logChangeNotifier('On dispose $runtimeType');
    super.dispose();
  }
}
