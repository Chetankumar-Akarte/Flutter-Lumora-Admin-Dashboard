import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../dashboard/views/dashboard_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../viewmodel/navigation_provider.dart';
import 'app_footer.dart';
import 'app_sidebar.dart';
import 'app_topbar.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final navState = ref.watch(navigationProvider);
    final isMobile = ResponsiveLayout.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      drawer: isMobile ? const Drawer(child: AppSidebar(isDrawer: true)) : null,
      body: Row(
        children: [
          // Sidebar on Desktop / Tablet
          if (!isMobile) const AppSidebar(),

          // Main App Area
          Expanded(
            child: Column(
              children: [
                AppTopbar(
                  onMenuPressed: () {
                    if (isMobile) {
                      _scaffoldKey.currentState?.openDrawer();
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    color: theme.scaffoldBackgroundColor,
                    child: _buildCurrentPage(navState.selectedPage),
                  ),
                ),
                const AppFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage(String pageKey) {
    switch (pageKey) {
      case 'dashboard':
      case 'dashboard-analytics':
      case 'dashboard-ecommerce':
      case 'dashboard-crm':
      case 'dashboard-project':
      case 'dashboard-finance':
      case 'dashboard-hrm':
      case 'dashboard-saas':
      case 'dashboard-support':
        return const DashboardScreen();
      case 'profile':
      case 'user-profile':
      case 'pages-profile':
        return const ProfileScreen();
      default:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.dashboard_customize_outlined, size: 48),
              const SizedBox(height: 12),
              Text(
                'Page: $pageKey',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text('Under construction in demo mode'),
            ],
          ),
        );
    }
  }
}
