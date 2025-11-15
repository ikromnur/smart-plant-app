import 'package:flutter/widgets.dart';
import 'state/hydroponic_store.dart';

class AppState extends InheritedNotifier<HydroponicStore> {
  const AppState({super.key, required HydroponicStore store, required super.child})
      : super(notifier: store);

  static HydroponicStore of(BuildContext context) {
    final AppState? inherited = context.dependOnInheritedWidgetOfExactType<AppState>();
    return inherited!.notifier!;
  }
}