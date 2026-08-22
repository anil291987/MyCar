import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/brand.dart';
import '../../domain/repositories/brand_repository.dart';
import '../../domain/usecases/set_brand.dart';

class BrandCubit extends Cubit<AppBrand> {
  final BrandRepository _repository;
  late final SetBrand _setBrand;

  BrandCubit(this._repository) : super(_repository.brand) {
    _setBrand = SetBrand(_repository);
    _repository.addListener(_onRepositoryChanged);
  }

  void _onRepositoryChanged() => emit(_repository.brand);

  void setBrand(AppBrand brand) => _setBrand(brand);

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}
