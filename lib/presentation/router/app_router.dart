import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/shell/main_shell.dart';
import '../features/home/home_screen.dart';
import '../features/vehicle_status/vehicle_status_screen.dart';
import '../features/remote_control/remote_control_screen.dart';
import '../features/navigation/navigation_screen.dart';
import '../features/services/services_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/auth/create_account_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/privacy/privacy_settings_screen.dart';
import '../features/help/help_support_screen.dart';
import '../features/workshop/workshop_screen.dart';
import '../features/digital_store/digital_store_screen.dart';
import '../features/find_dealer/find_dealer_screen.dart';
import '../features/geofencing/geofencing_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacySettingsScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/workshop',
        builder: (context, state) => const WorkshopScreen(),
      ),
      GoRoute(
        path: '/digital-store',
        builder: (context, state) => const DigitalStoreScreen(),
      ),
      GoRoute(
        path: '/find-dealer',
        builder: (context, state) => const FindDealerScreen(),
      ),
      GoRoute(
        path: '/geofencing',
        builder: (context, state) => const GeofencingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/status',
                builder: (context, state) => const VehicleStatusScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/remote',
                builder: (context, state) => const RemoteControlScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/navigation',
                builder: (context, state) => const NavigationScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/services',
                builder: (context, state) => const ServicesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
