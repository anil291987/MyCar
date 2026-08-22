import 'package:flutter/material.dart';
import '../../domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl extends ChangeNotifier implements LocaleRepository {
  Locale? _locale;

  @override
  Locale? get locale => _locale;

  @override
  void setLocale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
