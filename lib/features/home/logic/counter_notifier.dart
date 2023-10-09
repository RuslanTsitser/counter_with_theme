import 'package:counter_with_theme/core/utils/logging/change_notifier_observer_mixin.dart';
import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier with ChangeNotifierObserverMixin {
  int _counter = 0;
  int get counter => _counter;

  void add(bool isDoubleIncrement) {
    _counter++;
    if (isDoubleIncrement) {
      _counter++;
    }
    if (_counter > 10) {
      _counter = 10;
    }
    notifyListeners();
  }

  void remove(bool isDoubleDecrement) {
    _counter--;
    if (isDoubleDecrement) {
      _counter--;
    }
    if (_counter < 0) {
      _counter = 0;
    }
    notifyListeners();
  }

  bool get showRemoveButton => _counter > 0;
  bool get showAddButton => _counter < 10;

  @override
  Map<String, dynamic> get properties => {
        'counter': _counter,
      };
}
