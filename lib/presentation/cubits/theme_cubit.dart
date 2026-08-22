import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/usecases/set_theme_mode.dart';

/// Cubit state is the selected [ThemeMode]. [isDark] is exposed as a
/// convenience getter (it depends on system brightness for
/// `ThemeMode.system`, resolved by the repository) rather than being part
/// of the emitted state.
class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeRepository _repository;
  late final SetThemeMode _setThemeMode;

  ThemeCubit(this._repository) : super(_repository.mode) {
    _setThemeMode = SetThemeMode(_repository);
    _repository.addListener(_onRepositoryChanged);
  }

  bool get isDark => _repository.isDark;

  void _onRepositoryChanged() => emit(_repository.mode);

  void setMode(ThemeMode mode) => _setThemeMode(mode);

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}
