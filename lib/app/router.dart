import 'package:go_router/go_router.dart';

import '../features/fuel/pages/fuel_form_page.dart';
import '../features/fuel/pages/fuel_list_page.dart';
import '../features/home/home_page.dart';
import '../features/splash/splash_page.dart';

import '../features/vehicles/models/vehicle.dart';
import '../features/vehicles/pages/vehicle_form_page.dart';
import '../features/vehicles/pages/vehicle_list_page.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,

  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: '/vehicles',
      name: 'vehicles',
      builder: (context, state) => const VehicleListPage(),
    ),

    GoRoute(
      path: '/vehicle',
      name: 'vehicle',
      builder: (context, state) {
        final vehicle = state.extra as Vehicle?;
        return VehicleFormPage(vehicle: vehicle);
      },
    ),

    GoRoute(
      path: '/fuel',
      name: 'fuel',
      builder: (context, state) => const FuelListPage(),
    ),

    GoRoute(
      path: '/fuel/new',
      name: 'fuel-new',
      builder: (context, state) => const FuelFormPage(),
    ),
  ],
);