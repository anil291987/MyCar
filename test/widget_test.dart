import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_car/app.dart';
import 'package:my_car/core/di/app_locator.dart';
import 'package:my_car/presentation/cubits/brand_cubit.dart';
import 'package:my_car/presentation/cubits/locale_cubit.dart';
import 'package:my_car/presentation/cubits/theme_cubit.dart';
import 'package:my_car/presentation/cubits/vehicle_cubit.dart';

void main() {
  testWidgets('App builds and shows the home screen', (WidgetTester tester) async {
    AppLocator.setup();
    await tester.pumpWidget(
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
    await tester.pumpAndSettle();

    expect(find.text('Mercedes-Benz'), findsWidgets);
  });
}
