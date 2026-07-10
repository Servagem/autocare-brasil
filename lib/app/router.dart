import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_page.dart';
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
      builder: (context, state) => const DashboardPage(),
    ),

    GoRoute(
      path: '/vehicle',
      name: 'vehicle',
      builder: (context, state) => const VehicleFormPage(),
    ),
  ],
);