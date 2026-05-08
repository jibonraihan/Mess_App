import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  void setTheme(ThemeMode mode) => state = mode;

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      return;
    }
    state = ThemeMode.dark;
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController();
});
