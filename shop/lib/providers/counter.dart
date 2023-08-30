import 'package:flutter/material.dart';

class CounterState {
  double _value = 0;

  void increment() => _value += 10;
  void decrement() => _value--;
  double get value => _value;

  bool isDifferent(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterState state = CounterState();
  CounterProvider({required Widget child}) : super(child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.isDifferent(state);
  }
}
