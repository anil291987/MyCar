import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Locale;

/// Source of truth for the app's selected locale.
abstract class LocaleRepository implements Listenable {
  static const supportedLocales = [Locale('en'), Locale('de')];

  Locale? get locale;

  void setLocale(Locale? locale);
}
