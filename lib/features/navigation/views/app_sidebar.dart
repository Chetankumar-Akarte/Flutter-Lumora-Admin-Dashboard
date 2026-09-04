import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/avatar_badge.dart';
import '../viewmodel/navigation_provider.dart';

class SidebarSubItem {
  final String label;
  final String pageKey;
  final String? badge;

  const SidebarSubItem({
    required this.label,
    required this.pageKey,
    this.badge,
  });
}

class AppSidebar extends ConsumerWidget {
  final bool isDrawer;

  const AppSidebar({super.key, this.isDrawer = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigationProvider);
    final navNotifier = ref.read(navigationProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isCollapsed = !isDrawer && navState.isSidebarCollapsed;
    final width = isCollapsed ? AppDimensions.sidebarRailWidth : AppDimensions.sidebarWidth;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
      width: width,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          right: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      child: Column(
        children: [
          // 1. Brand Header
          Container(
            height: AppDimensions.topbarHeight,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 12 : 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
            ),
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                // Brand Mark Logo
                Tooltip(
                  message: isCollapsed ? 'Expand sidebar' : 'Lumora',
                  child: InkWell(
                    onTap: isCollapsed ? () => navNotifier.toggleSidebar() : null,
                    borderRadius: AppDimensions.rMd,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5B5BF7), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: AppDimensions.rMd,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brand.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.cubes,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Lumora',
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.heading(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (!isDrawer)
                    IconButton(
                      icon: const Icon(Icons.menu_open_rounded, size: 20),
                      color: theme.textTheme.bodyMedium?.color,
                      tooltip: 'Collapse sidebar',
                      onPressed: () => navNotifier.toggleSidebar(),
                    ),
                ],
              ],
            ),
          ),

          // 2. Nav Items Scrollable
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: isCollapsed ? 8 : 10,
              ),
              children: [
                // ==================== MAIN ====================
                if (!isCollapsed)
                  _buildSectionHeading('MAIN', theme)
                else
                  const SizedBox(height: 8),

                _buildNavItem(
                  icon: FontAwesomeIcons.house,
                  label: 'Home',
                  pageKey: 'dashboard',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('dashboard');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),

                _buildExpandableNavItem(
                  menuKey: 'dashboards',
                  icon: FontAwesomeIcons.chartLine,
                  label: 'Dashboards',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Analytics', pageKey: 'dashboard-analytics'),
                    SidebarSubItem(label: 'E-commerce', pageKey: 'dashboard-ecommerce'),
                    SidebarSubItem(label: 'CRM', pageKey: 'dashboard-crm'),
                    SidebarSubItem(label: 'Project', pageKey: 'dashboard-project'),
                    SidebarSubItem(label: 'Finance', pageKey: 'dashboard-finance'),
                    SidebarSubItem(label: 'HRM', pageKey: 'dashboard-hrm'),
                    SidebarSubItem(label: 'SaaS', pageKey: 'dashboard-saas'),
                    SidebarSubItem(label: 'Support', pageKey: 'dashboard-support'),
                    SidebarSubItem(label: 'Warehouse', pageKey: 'dashboard-warehouse'),
                    SidebarSubItem(label: 'Operations', pageKey: 'dashboard-operations'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'apps',
                  icon: FontAwesomeIcons.tableCellsLarge,
                  label: 'Apps',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Chat', pageKey: 'chat'),
                    SidebarSubItem(label: 'Email', pageKey: 'email'),
                    SidebarSubItem(label: 'Calendar', pageKey: 'calendar'),
                    SidebarSubItem(label: 'Kanban', pageKey: 'kanban'),
                    SidebarSubItem(label: 'File Manager', pageKey: 'file-manager'),
                    SidebarSubItem(label: 'Gallery', pageKey: 'gallery'),
                    SidebarSubItem(label: 'Contacts', pageKey: 'contacts'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'ecommerce',
                  icon: FontAwesomeIcons.bagShopping,
                  label: 'E-commerce',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Dashboard', pageKey: 'dashboard-ecommerce'),
                    SidebarSubItem(label: 'Products', pageKey: 'products'),
                    SidebarSubItem(label: 'Orders', pageKey: 'orders'),
                    SidebarSubItem(label: 'Customers', pageKey: 'customers'),
                    SidebarSubItem(label: 'Categories', pageKey: 'categories'),
                    SidebarSubItem(label: 'Inventory', pageKey: 'inventory'),
                    SidebarSubItem(label: 'Invoice', pageKey: 'invoice'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'auth',
                  icon: FontAwesomeIcons.userLock,
                  label: 'Authentication',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Login', pageKey: 'login'),
                    SidebarSubItem(label: 'Register', pageKey: 'register'),
                    SidebarSubItem(label: 'Forgot Password', pageKey: 'forgot-password'),
                    SidebarSubItem(label: 'Reset Password', pageKey: 'reset-password'),
                    SidebarSubItem(label: 'Verify OTP', pageKey: 'verify-otp'),
                    SidebarSubItem(label: 'Lock Screen', pageKey: 'lock-screen'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'users',
                  icon: FontAwesomeIcons.users,
                  label: 'Users',
                  badge: '12',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'All Users', pageKey: 'users-list'),
                    SidebarSubItem(label: 'User Profile', pageKey: 'user-profile'),
                    SidebarSubItem(label: 'Roles & Permissions', pageKey: 'roles'),
                    SidebarSubItem(label: 'Permissions', pageKey: 'permissions'),
                  ],
                ),

                // ==================== LAYOUTS ====================
                const SizedBox(height: 16),
                if (!isCollapsed)
                  _buildSectionHeading('LAYOUTS', theme)
                else
                  const SizedBox(height: 8),

                _buildExpandableNavItem(
                  menuKey: 'layouts',
                  icon: FontAwesomeIcons.tableColumns,
                  label: 'Layout Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Sidebar Light', pageKey: 'sidebar-light'),
                    SidebarSubItem(label: 'Sidebar Dark', pageKey: 'sidebar-dark'),
                    SidebarSubItem(label: 'Sidebar Compact', pageKey: 'sidebar-compact'),
                    SidebarSubItem(label: 'Icon Only', pageKey: 'sidebar-icon-only'),
                    SidebarSubItem(label: 'Hidden Sidebar', pageKey: 'sidebar-hidden'),
                    SidebarSubItem(label: 'Boxed Layout', pageKey: 'boxed-layout'),
                    SidebarSubItem(label: 'Fluid Layout', pageKey: 'fluid-layout'),
                  ],
                ),

                // ==================== UI KIT ====================
                const SizedBox(height: 16),
                if (!isCollapsed)
                  _buildSectionHeading('UI KIT', theme)
                else
                  const SizedBox(height: 8),

                _buildNavItem(
                  icon: FontAwesomeIcons.grip,
                  label: 'Widgets',
                  pageKey: 'widgets',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('widgets');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),

                _buildExpandableNavItem(
                  menuKey: 'basic-ui',
                  icon: FontAwesomeIcons.cube,
                  label: 'Basic UI',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Buttons', pageKey: 'ui-buttons'),
                    SidebarSubItem(label: 'Cards', pageKey: 'ui-cards'),
                    SidebarSubItem(label: 'Alerts', pageKey: 'ui-alerts'),
                    SidebarSubItem(label: 'Badges', pageKey: 'ui-badges'),
                    SidebarSubItem(label: 'Tabs', pageKey: 'ui-tabs'),
                    SidebarSubItem(label: 'Modals', pageKey: 'ui-modals'),
                    SidebarSubItem(label: 'Dropdowns', pageKey: 'ui-dropdowns'),
                    SidebarSubItem(label: 'Avatars', pageKey: 'ui-avatars'),
                    SidebarSubItem(label: 'Progress', pageKey: 'ui-progress'),
                    SidebarSubItem(label: 'Tooltips & Popovers', pageKey: 'ui-tooltips'),
                    SidebarSubItem(label: 'Accordion', pageKey: 'ui-accordion'),
                    SidebarSubItem(label: 'Offcanvas', pageKey: 'ui-offcanvas'),
                    SidebarSubItem(label: 'Toasts', pageKey: 'ui-toasts'),
                    SidebarSubItem(label: 'Pagination', pageKey: 'ui-pagination'),
                    SidebarSubItem(label: 'List Group', pageKey: 'ui-list-group'),
                    SidebarSubItem(label: 'Typography', pageKey: 'ui-typography'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'advanced-ui',
                  icon: FontAwesomeIcons.wandMagicSparkles,
                  label: 'Advanced UI',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Popups', pageKey: 'ui-popups'),
                    SidebarSubItem(label: 'Notifications', pageKey: 'ui-notifications'),
                    SidebarSubItem(label: 'Draggable', pageKey: 'ui-draggable'),
                    SidebarSubItem(label: 'Clipboard', pageKey: 'ui-clipboard'),
                    SidebarSubItem(label: 'Context Menu', pageKey: 'ui-context-menu'),
                    SidebarSubItem(label: 'Sliders', pageKey: 'ui-sliders'),
                    SidebarSubItem(label: 'Carousel', pageKey: 'ui-carousel'),
                    SidebarSubItem(label: 'Tree View', pageKey: 'ui-treeview'),
                    SidebarSubItem(label: 'Loaders', pageKey: 'ui-loaders'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'forms',
                  icon: FontAwesomeIcons.keyboard,
                  label: 'Forms',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Basic Forms', pageKey: 'forms-basic'),
                    SidebarSubItem(label: 'Advanced Forms', pageKey: 'forms-advanced'),
                    SidebarSubItem(label: 'Validation', pageKey: 'forms-validation'),
                    SidebarSubItem(label: 'Wizard', pageKey: 'forms-wizard'),
                    SidebarSubItem(label: 'File Upload', pageKey: 'forms-upload'),
                    SidebarSubItem(label: 'Text Editor', pageKey: 'forms-editor'),
                    SidebarSubItem(label: 'Code Editor', pageKey: 'forms-code'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'tables',
                  icon: FontAwesomeIcons.table,
                  label: 'Tables',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Basic Tables', pageKey: 'tables-basic'),
                    SidebarSubItem(label: 'DataTables', pageKey: 'tables-datatables'),
                    SidebarSubItem(label: 'Editable Tables', pageKey: 'tables-editable'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'charts',
                  icon: FontAwesomeIcons.chartColumn,
                  label: 'Charts',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Apex Charts', pageKey: 'charts-apex'),
                    SidebarSubItem(label: 'Chart.js', pageKey: 'charts-chartjs'),
                    SidebarSubItem(label: 'Morris', pageKey: 'charts-morris'),
                    SidebarSubItem(label: 'Sparkline', pageKey: 'charts-sparkline'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'maps',
                  icon: FontAwesomeIcons.mapLocationDot,
                  label: 'Maps',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Google Maps', pageKey: 'maps-google'),
                    SidebarSubItem(label: 'Leaflet', pageKey: 'maps-leaflet'),
                    SidebarSubItem(label: 'Vector Maps', pageKey: 'maps-vector'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'icons-pages',
                  icon: FontAwesomeIcons.icons,
                  label: 'Icons Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Font Awesome', pageKey: 'icons-fa'),
                    SidebarSubItem(label: 'Material Design', pageKey: 'icons-material'),
                    SidebarSubItem(label: 'Flag Icons', pageKey: 'icons-flag'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'general-pages',
                  icon: FontAwesomeIcons.fileLines,
                  label: 'General Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: 'Blank Page', pageKey: 'pages-blank'),
                    SidebarSubItem(label: 'FAQ', pageKey: 'pages-faq'),
                    SidebarSubItem(label: 'Notifications', pageKey: 'pages-notifications'),
                    SidebarSubItem(label: 'Pricing', pageKey: 'pages-pricing'),
                    SidebarSubItem(label: 'Search Results', pageKey: 'pages-search'),
                    SidebarSubItem(label: 'Timeline', pageKey: 'pages-timeline'),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'error-pages',
                  icon: FontAwesomeIcons.triangleExclamation,
                  label: 'Error Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  selectedPage: navState.selectedPage,
                  navNotifier: navNotifier,
                  isDrawer: isDrawer,
                  context: context,
                  theme: theme,
                  isDark: isDark,
                  subItems: const [
                    SidebarSubItem(label: '404', pageKey: 'errors-404'),
                    SidebarSubItem(label: '500', pageKey: 'errors-500'),
                    SidebarSubItem(label: '403', pageKey: 'errors-403'),
                    SidebarSubItem(label: 'Maintenance', pageKey: 'errors-maintenance'),
                    SidebarSubItem(label: 'Coming Soon', pageKey: 'errors-coming-soon'),
                  ],
                ),

                // ==================== ACCOUNT ====================
                const SizedBox(height: 16),
                if (!isCollapsed)
                  _buildSectionHeading('ACCOUNT', theme)
                else
                  const SizedBox(height: 8),

                _buildNavItem(
                  icon: FontAwesomeIcons.circleUser,
                  label: 'Profile',
                  pageKey: 'profile',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('profile');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),

                _buildNavItem(
                  icon: FontAwesomeIcons.gear,
                  label: 'Settings',
                  pageKey: 'settings',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('settings');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),

                _buildNavItem(
                  icon: FontAwesomeIcons.rightFromBracket,
                  label: 'Sign in',
                  pageKey: 'login',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('login');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),

                _buildNavItem(
                  icon: FontAwesomeIcons.bookOpen,
                  label: 'Documentation',
                  pageKey: 'docs',
                  selectedPage: navState.selectedPage,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    navNotifier.selectPage('docs');
                    if (isDrawer) Navigator.of(context).pop();
                  },
                  theme: theme,
                  isDark: isDark,
                ),
              ],
            ),
          ),

          // 3. Sidebar Footer User Profile
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                navNotifier.selectPage('profile');
                if (isDrawer) Navigator.of(context).pop();
              },
              child: Container(
                height: 64,
                padding: EdgeInsets.symmetric(
                  horizontal: isCollapsed ? 12 : 16,
                ),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: theme.colorScheme.outline)),
                ),
                child: isCollapsed
                    ? const Center(
                        child: Tooltip(
                          message: 'Chetankumar Akarte\nSenior Solution Architect',
                          child: AvatarBadge(
                            imageUrl: 'https://avatars.githubusercontent.com/u/27378345?v=4',
                            size: 34,
                            isOnline: true,
                          ),
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AvatarBadge(
                            imageUrl: 'https://avatars.githubusercontent.com/u/27378345?v=4',
                            size: 34,
                            isOnline: true,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chetankumar Akarte',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.heading(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Senior Solution Architect',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.body(
                                    fontSize: 11,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
      child: Text(
        title,
        style: AppTypography.heading(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required FaIconData icon,
    required String label,
    required String pageKey,
    required String selectedPage,
    required bool isCollapsed,
    required VoidCallback onTap,
    required ThemeData theme,
    required bool isDark,
    String? badge,
  }) {
    final isSelected = selectedPage == pageKey;
    final activeBg = isDark ? AppColors.brandDarkSoft : AppColors.brandSoft;
    final activeColor = isDark ? AppColors.brandDark : AppColors.brand;

    final itemWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDimensions.rMd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCollapsed ? 12 : 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : Colors.transparent,
            borderRadius: AppDimensions.rMd,
          ),
          child: Row(
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              FaIcon(
                icon,
                size: 15,
                color: isSelected ? activeColor : theme.textTheme.bodyMedium?.color,
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.heading(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? activeColor : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
                      borderRadius: AppDimensions.rPill,
                    ),
                    child: Text(
                      badge,
                      style: AppTypography.heading(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: activeColor,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );

    if (isCollapsed) {
      return Tooltip(
        message: label,
        waitDuration: const Duration(milliseconds: 300),
        child: itemWidget,
      );
    }

    return itemWidget;
  }

  Widget _buildExpandableNavItem({
    required String menuKey,
    required FaIconData icon,
    required String label,
    required bool isCollapsed,
    required Set<String> expandedMenus,
    required String selectedPage,
    required NavigationNotifier navNotifier,
    required bool isDrawer,
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required List<SidebarSubItem> subItems,
    String? badge,
  }) {
    final isExpanded = expandedMenus.contains(menuKey);
    final isAnyChildSelected = subItems.any((item) => item.pageKey == selectedPage);
    final activeColor = isDark ? AppColors.brandDark : AppColors.brand;
    final activeBg = isDark ? AppColors.brandDarkSoft : AppColors.brandSoft;

    if (isCollapsed) {
      return Tooltip(
        message: label,
        waitDuration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Builder(
            builder: (buttonContext) {
              return InkWell(
                onTap: () {
                  _showFlyoutMenu(
                    context: buttonContext,
                    label: label,
                    icon: icon,
                    badge: badge,
                    subItems: subItems,
                    selectedPage: selectedPage,
                    navNotifier: navNotifier,
                    isDrawer: isDrawer,
                    theme: theme,
                    isDark: isDark,
                  );
                },
                borderRadius: AppDimensions.rMd,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isAnyChildSelected ? activeBg : Colors.transparent,
                    borderRadius: AppDimensions.rMd,
                  ),
                  child: Center(
                    child: FaIcon(
                      icon,
                      size: 15,
                      color: isAnyChildSelected ? activeColor : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => navNotifier.toggleSubmenu(menuKey),
            borderRadius: AppDimensions.rMd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  FaIcon(
                    icon,
                    size: 15,
                    color: (isExpanded || isAnyChildSelected)
                        ? activeColor
                        : theme.textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.heading(
                        fontSize: 13,
                        fontWeight: (isExpanded || isAnyChildSelected) ? FontWeight.w600 : FontWeight.w500,
                        color: (isExpanded || isAnyChildSelected) ? activeColor : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
                        borderRadius: AppDimensions.rPill,
                      ),
                      child: Text(
                        badge,
                        style: AppTypography.heading(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: activeColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 4, bottom: 4),
              child: Column(
                children: subItems
                    .map((item) => _buildSubItem(
                          item.label,
                          item.pageKey,
                          selectedPage,
                          navNotifier,
                          isDrawer,
                          context,
                          theme,
                          isDark,
                          badge: item.badge,
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  void _showFlyoutMenu({
    required BuildContext context,
    required String label,
    required FaIconData icon,
    required String? badge,
    required List<SidebarSubItem> subItems,
    required String selectedPage,
    required NavigationNotifier navNotifier,
    required bool isDrawer,
    required ThemeData theme,
    required bool isDark,
  }) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final translation = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;

    final position = RelativeRect.fromRect(
      Rect.fromLTWH(
        translation.dx + size.width + 6,
        translation.dy - 6,
        size.width,
        size.height,
      ),
      Offset.zero & overlay.size,
    );

    final activeColor = isDark ? AppColors.brandDark : AppColors.brand;
    final activeBg = isDark ? AppColors.brandDarkSoft : AppColors.brandSoft;
    final surfaceColor = isDark ? AppColors.darkSurface2 : AppColors.lightSurface;

    showMenu<String>(
      context: context,
      position: position,
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 260,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.rLg,
        side: BorderSide(
          color: isDark ? const Color(0xFF2A2E3D) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      color: surfaceColor,
      surfaceTintColor: Colors.transparent,
      items: [
        // Category Header
        PopupMenuItem<String>(
          enabled: false,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          child: Row(
            children: [
              FaIcon(icon, size: 13, color: activeColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.heading(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: activeBg,
                    borderRadius: AppDimensions.rPill,
                  ),
                  child: Text(
                    badge,
                    style: AppTypography.heading(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: activeColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        // Submenu items
        ...subItems.map((subItem) {
          final isSelected = selectedPage == subItem.pageKey;
          return PopupMenuItem<String>(
            value: subItem.pageKey,
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? activeBg : Colors.transparent,
                borderRadius: AppDimensions.rSm,
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? activeColor : (theme.textTheme.bodySmall?.color ?? Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      subItem.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? activeColor : theme.colorScheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                  if (subItem.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: activeBg,
                        borderRadius: AppDimensions.rPill,
                      ),
                      child: Text(
                        subItem.badge!,
                        style: AppTypography.heading(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: activeColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    ).then((value) {
      if (value != null) {
        navNotifier.selectPage(value);
        if (isDrawer && context.mounted) Navigator.of(context).pop();
      }
    });
  }

  Widget _buildSubItem(
    String label,
    String pageKey,
    String selectedPage,
    NavigationNotifier navNotifier,
    bool isDrawer,
    BuildContext context,
    ThemeData theme,
    bool isDark, {
    String? badge,
  }) {
    final isSelected = selectedPage == pageKey;
    final activeColor = isDark ? AppColors.brandDark : AppColors.brand;

    return InkWell(
      onTap: () {
        navNotifier.selectPage(pageKey);
        if (isDrawer) Navigator.of(context).pop();
      },
      borderRadius: AppDimensions.rSm,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        margin: const EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.brandDarkSoft : AppColors.brandSoft)
              : Colors.transparent,
          borderRadius: AppDimensions.rSm,
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? activeColor : theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? activeColor : theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
                  borderRadius: AppDimensions.rPill,
                ),
                child: Text(
                  badge,
                  style: AppTypography.heading(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: activeColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
