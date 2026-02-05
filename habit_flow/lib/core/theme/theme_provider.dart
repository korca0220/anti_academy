import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/habit/presentation/riverpod/habit_providers.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    return _loadTheme();
  }

  ThemeMode _loadTheme() {
    // TODO: 1. SharedPreferences에서 저장된 테마를 불러오세요. (key: 'theme_mode')
    // String? savedTheme = ...
    // 'light' -> ThemeMode.light
    // 'dark' -> ThemeMode.dark
    // 그 외 -> ThemeMode.system
    final _sharedPreferences = ref.read(sharedPreferencesProvider);

    final savedTheme = _sharedPreferences.getString(_key);

    if (savedTheme == 'light') {
      return ThemeMode.light;
    } else if (savedTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void toggleTheme() {
    // TODO: 2. 현재 상태(state)가 light면 dark로, 아니면 light로 변경하세요.
    // 변경 후 _saveTheme를 호출하여 저장하세요.

    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }

    _saveTheme(state);
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    // TODO: 3. 변경된 테마를 SharedPreferences에 저장하세요.
    // ThemeMode.light -> 'light'
    // ThemeMode.dark -> 'dark'
    // 그 외 -> 'system'
    final _sharedPreferences = ref.read(sharedPreferencesProvider);

    if (mode == ThemeMode.light) {
      await _sharedPreferences.setString(_key, 'light');
    } else if (mode == ThemeMode.dark) {
      await _sharedPreferences.setString(_key, 'dark');
    } else {
      await _sharedPreferences.setString(_key, 'system');
    }
  }
}
