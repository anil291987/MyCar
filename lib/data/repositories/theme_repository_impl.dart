import 'package:flutter/material.dart';
import '../../domain/repositories/theme_repository.dart';

/// In-memory theme preference store (no persistence yet — matches the
/// app's original `ThemeController` behavior of resetting on relaunch).
class ThemeRepositoryImpl extends ChangeNotifier implements ThemeRepository {
  ThemeMode _mode = ThemeMode.dark;

  @override
  ThemeMode get mode => _mode;

  @override
  bool get isDark {
    if (_mode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _mode == ThemeMode.dark;
  }

  @override
  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }
}
