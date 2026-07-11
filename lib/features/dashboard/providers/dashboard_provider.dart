import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/dashboard_controller.dart';
import '../repositories/dashboard_repository.dart';
import '../services/dashboard_service.dart';
import '../models/dashboard_data.dart';

final dashboardRepositoryProvider =
    Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

final dashboardServiceProvider =
    Provider<DashboardService>((ref) {
  return DashboardService(
    ref.read(dashboardRepositoryProvider),
  );
});

final dashboardControllerProvider =
    StateNotifierProvider<
        DashboardController,
        AsyncValue<DashboardData>>((ref) {
});