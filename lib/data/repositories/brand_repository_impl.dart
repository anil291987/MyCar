import 'package:flutter/foundation.dart';
import '../../domain/entities/brand.dart';
import '../../domain/repositories/brand_repository.dart';

class BrandRepositoryImpl extends ChangeNotifier implements BrandRepository {
  AppBrand _brand = AppBrand.steel;

  @override
  AppBrand get brand => _brand;

  @override
  void setBrand(AppBrand brand) {
    if (_brand == brand) return;
    _brand = brand;
    notifyListeners();
  }
}
