import 'package:flutter/foundation.dart';
import '../entities/brand.dart';

/// Source of truth for the selected accent-color theme (steel, crimson,
/// champagne). Brand-agnostic: this is a color preference, not a
/// manufacturer identity.
abstract class BrandRepository implements Listenable {
  AppBrand get brand;

  void setBrand(AppBrand brand);
}
