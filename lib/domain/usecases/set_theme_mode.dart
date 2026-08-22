import 'package:flutter/material.dart' show ThemeMode;
import '../repositories/theme_repository.dart';

class SetThemeMode {
  final ThemeRepository _repository;
  SetThemeMode(this._repository);

  void call(ThemeMode mode) => _repository.setMode(mode);
}
