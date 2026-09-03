import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';
import 'dashboard_state.dart';
import 'dashboard_viewmodel.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardViewModel(repo);
});
