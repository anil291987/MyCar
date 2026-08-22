import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/locale_repository.dart';
import '../../domain/usecases/set_locale.dart';

class LocaleCubit extends Cubit<Locale?> {
  final LocaleRepository _repository;
  late final SetLocale _setLocale;

  LocaleCubit(this._repository) : super(_repository.locale) {
    _setLocale = SetLocale(_repository);
    _repository.addListener(_onRepositoryChanged);
  }

  void _onRepositoryChanged() => emit(_repository.locale);

  void setLocale(Locale? locale) => _setLocale(locale);

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}
