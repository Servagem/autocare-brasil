import 'package:go_router/go_router.dart';

import '../features/fuel/pages/fuel_form_page.dart';
import '../features/fuel/pages/fuel_list_page.dart';
import '../features/home/home_page.dart';
import '../features/splash/splash_page.dart';
import '../features/vehicles/pages/vehicle_form_page.dart';


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
      path: '/vehicle',
      name: 'vehicle',
      builder: (context, state) => const VehicleFormPage(),
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