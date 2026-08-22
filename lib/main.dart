import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/di/app_locator.dart';
import 'presentation/cubits/brand_cubit.dart';
import 'presentation/cubits/locale_cubit.dart';
import 'presentation/cubits/theme_cubit.dart';
import 'presentation/cubits/vehicle_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocator.setup();

  void applyOverlayStyle() {
    final isDark = AppLocator.themeRepository.isDark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF5F5F7),
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  applyOverlayStyle();
  AppLocator.themeRepository.addListener(applyOverlayStyle);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VehicleCubit(AppLocator.vehicleRepository),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(AppLocator.themeRepository),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(AppLocator.localeRepository),
        ),
        BlocProvider(
          create: (_) => BrandCubit(AppLocator.brandRepository),
        ),
      ],
      child: const MercedesBenzApp(),
    ),
  );
}
