import 'package:go_router/go_router.dart';
import '../features/vehicles/pages/vehicle_form_page.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/splash/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/vehicle',
      builder: (context, state) => const VehicleFormPage(),
    ),
  ],
);
