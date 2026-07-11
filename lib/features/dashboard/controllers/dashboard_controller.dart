import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dashboard_data.dart';
import '../services/dashboard_service.dart';

class DashboardController extends StateNotifier<AsyncValue<DashboardData>> {
  DashboardController(this._service)
      : super(const AsyncLoading()) {
    loadDashboard();
  }

  final DashboardService _service;

  Future<void> loadDashboard() async {
    state = const AsyncLoading();

    try {
      final dashboard = await _service.loadDashboard();

      state = AsyncData(dashboard);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> refresh() async {
    await loadDashboard();
  }
}