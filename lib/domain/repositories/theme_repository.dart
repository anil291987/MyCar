import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;

/// Source of truth for the app's light/dark/system theme preference.
abstract class ThemeRepository implements Listenable {
  ThemeMode get mode;
  bool get isDark;

  void setMode(ThemeMode mode);
}
