import 'package:flutter/widgets.dart';

class SharedChangeNotifier<T> extends ChangeNotifier {
  SharedChangeNotifier(this._manager) {
    _manager._notifiers.add(this);
  }
  final SharedChangeNotifierManager<T> _manager;
  set value(T value) => _manager.value = value;
  T get value => _manager.value;
  void _notifyListeners() => super.notifyListeners();
  @override
  void dispose() {
    _manager._notifiers.remove(this);
    super.dispose();
  }
}

class SharedChangeNotifierManager<T> {
  SharedChangeNotifierManager({
    required T value,
  }) : _value = value;
  T _value;
  final List<SharedChangeNotifier> _notifiers = [];
  set value(T value) {
    _value = value;
    for(var notifier in _notifiers) {
      notifier._notifyListeners();
    }
  }
  T get value => _value;
  SharedChangeNotifier<T> createNotifier() => SharedChangeNotifier(this);
  void dispose() {
    for(var notifier in _notifiers) {
      notifier.dispose();
    }
  }
}
