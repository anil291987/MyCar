import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/repositories/locale_repository.dart';
import 'presentation/cubits/brand_cubit.dart';
import 'presentation/cubits/locale_cubit.dart';
import 'presentation/cubits/theme_cubit.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/router/app_router.dart';
import 'l10n/generated/app_localizations.dart';

class MercedesBenzApp extends StatelessWidget {
  const MercedesBenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;
    final brand = context.watch<BrandCubit>().state;
    return MaterialApp.router(
      key: ValueKey((themeMode, locale, brand)),
      title: 'Vehicle Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: LocaleRepository.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.router,
    );
  }
}
