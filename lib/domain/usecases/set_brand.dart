import '../entities/brand.dart';
import '../repositories/brand_repository.dart';

class SetBrand {
  final BrandRepository _repository;
  SetBrand(this._repository);

  void call(AppBrand brand) => _repository.setBrand(brand);
}
