import 'package:flutter/material.dart' show Locale;
import '../repositories/locale_repository.dart';

class SetLocale {
  final LocaleRepository _repository;
  SetLocale(this._repository);

  void call(Locale? locale) => _repository.setLocale(locale);
}
