import '../../data/repositories/brand_repository_impl.dart';
import '../../data/repositories/in_memory_vehicle_repository.dart';
import '../../data/repositories/locale_repository_impl.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../domain/repositories/brand_repository.dart';
import '../../domain/repositories/locale_repository.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/repositories/vehicle_repository.dart';

/// Minimal manual service locator — wires concrete data-layer
/// implementations behind their domain interfaces once, at startup.
///
/// Kept deliberately tiny (no get_it/injectable) since this app has a
/// handful of singletons. Widgets that have a `BuildContext` should
/// prefer the view models exposed via Provider; [AppLocator] exists for the
/// few call sites (e.g. [AppColors], [AppTypography], [MBCard],
/// [MBGlassSurface]) that read theme state without a `BuildContext`.
class AppLocator {
  AppLocator._();

  static late final VehicleRepository vehicleRepository;
  static late final ThemeRepository themeRepository;
  static late final LocaleRepository localeRepository;
  static late final BrandRepository brandRepository;

  static void setup() {
    vehicleRepository = InMemoryVehicleRepository();
    themeRepository = ThemeRepositoryImpl();
    localeRepository = LocaleRepositoryImpl();
    brandRepository = BrandRepositoryImpl();
  }
}
