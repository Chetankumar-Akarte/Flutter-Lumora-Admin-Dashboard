import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/avatar_badge.dart';
import '../viewmodel/navigation_provider.dart';

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
                Container(
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
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Text(
                    'Lumora',
                    style: AppTypography.heading(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                  onToggle: () => navNotifier.toggleSubmenu('dashboards'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Analytics', 'dashboard-analytics', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('E-commerce', 'dashboard-ecommerce', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('CRM', 'dashboard-crm', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Project', 'dashboard-project', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Finance', 'dashboard-finance', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('HRM', 'dashboard-hrm', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('SaaS', 'dashboard-saas', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Support', 'dashboard-support', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Warehouse', 'dashboard-warehouse', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Operations', 'dashboard-operations', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'apps',
                  icon: FontAwesomeIcons.tableCellsLarge,
                  label: 'Apps',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('apps'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Chat', 'chat', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Email', 'email', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Calendar', 'calendar', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Kanban', 'kanban', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('File Manager', 'file-manager', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Gallery', 'gallery', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Contacts', 'contacts', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'ecommerce',
                  icon: FontAwesomeIcons.bagShopping,
                  label: 'E-commerce',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('ecommerce'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Dashboard', 'dashboard-ecommerce', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Products', 'products', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Orders', 'orders', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Customers', 'customers', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Categories', 'categories', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Inventory', 'inventory', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Invoice', 'invoice', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'auth',
                  icon: FontAwesomeIcons.userLock,
                  label: 'Authentication',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('auth'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Login', 'login', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Register', 'register', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Forgot Password', 'forgot-password', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Reset Password', 'reset-password', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Verify OTP', 'verify-otp', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Lock Screen', 'lock-screen', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'users',
                  icon: FontAwesomeIcons.users,
                  label: 'Users',
                  badge: '12',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('users'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('All Users', 'users-list', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('User Profile', 'user-profile', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Roles & Permissions', 'roles', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Permissions', 'permissions', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
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
                  onToggle: () => navNotifier.toggleSubmenu('layouts'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Sidebar Light', 'sidebar-light', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Sidebar Dark', 'sidebar-dark', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Sidebar Compact', 'sidebar-compact', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Icon Only', 'sidebar-icon-only', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Hidden Sidebar', 'sidebar-hidden', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Boxed Layout', 'boxed-layout', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Fluid Layout', 'fluid-layout', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
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
                  onToggle: () => navNotifier.toggleSubmenu('basic-ui'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Buttons', 'ui-buttons', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Cards', 'ui-cards', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Alerts', 'ui-alerts', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Badges', 'ui-badges', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Tabs', 'ui-tabs', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Modals', 'ui-modals', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Dropdowns', 'ui-dropdowns', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Avatars', 'ui-avatars', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Progress', 'ui-progress', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Tooltips & Popovers', 'ui-tooltips', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Accordion', 'ui-accordion', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Offcanvas', 'ui-offcanvas', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Toasts', 'ui-toasts', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Pagination', 'ui-pagination', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('List Group', 'ui-list-group', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Typography', 'ui-typography', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'advanced-ui',
                  icon: FontAwesomeIcons.wandMagicSparkles,
                  label: 'Advanced UI',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('advanced-ui'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Popups', 'ui-popups', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Notifications', 'ui-notifications', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Draggable', 'ui-draggable', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Clipboard', 'ui-clipboard', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Context Menu', 'ui-context-menu', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Sliders', 'ui-sliders', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Carousel', 'ui-carousel', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Tree View', 'ui-treeview', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Loaders', 'ui-loaders', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'forms',
                  icon: FontAwesomeIcons.keyboard,
                  label: 'Forms',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('forms'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Basic Forms', 'forms-basic', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Advanced Forms', 'forms-advanced', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Validation', 'forms-validation', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Wizard', 'forms-wizard', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('File Upload', 'forms-upload', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Text Editor', 'forms-editor', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Code Editor', 'forms-code', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'tables',
                  icon: FontAwesomeIcons.table,
                  label: 'Tables',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('tables'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Basic Tables', 'tables-basic', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('DataTables', 'tables-datatables', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Editable Tables', 'tables-editable', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'charts',
                  icon: FontAwesomeIcons.chartColumn,
                  label: 'Charts',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('charts'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Apex Charts', 'charts-apex', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Chart.js', 'charts-chartjs', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Morris', 'charts-morris', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Sparkline', 'charts-sparkline', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'maps',
                  icon: FontAwesomeIcons.mapLocationDot,
                  label: 'Maps',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('maps'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Google Maps', 'maps-google', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Leaflet', 'maps-leaflet', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Vector Maps', 'maps-vector', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'icons-pages',
                  icon: FontAwesomeIcons.icons,
                  label: 'Icons Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('icons-pages'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Font Awesome', 'icons-fa', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Material Design', 'icons-material', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Flag Icons', 'icons-flag', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'general-pages',
                  icon: FontAwesomeIcons.fileLines,
                  label: 'General Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('general-pages'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('Blank Page', 'pages-blank', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('FAQ', 'pages-faq', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Notifications', 'pages-notifications', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Pricing', 'pages-pricing', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Search Results', 'pages-search', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Timeline', 'pages-timeline', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                  ],
                ),

                _buildExpandableNavItem(
                  menuKey: 'error-pages',
                  icon: FontAwesomeIcons.triangleExclamation,
                  label: 'Error Pages',
                  isCollapsed: isCollapsed,
                  expandedMenus: navState.expandedMenus,
                  onToggle: () => navNotifier.toggleSubmenu('error-pages'),
                  theme: theme,
                  isDark: isDark,
                  children: [
                    _buildSubItem('404', 'errors-404', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('500', 'errors-500', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('403', 'errors-403', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Maintenance', 'errors-maintenance', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
                    _buildSubItem('Coming Soon', 'errors-coming-soon', navState.selectedPage, navNotifier, isDrawer, context, theme, isDark),
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
          Container(
            height: 64,
            padding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 12 : 16,
            ),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: theme.colorScheme.outline)),
            ),
            child: isCollapsed
                ? const Center(
                    child: AvatarBadge(
                      imageUrl: 'https://avatars.githubusercontent.com/u/27378345?v=4',
                      size: 34,
                      isOnline: true,
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

    return Padding(
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
  }

  Widget _buildExpandableNavItem({
    required String menuKey,
    required FaIconData icon,
    required String label,
    required bool isCollapsed,
    required Set<String> expandedMenus,
    required VoidCallback onToggle,
    required ThemeData theme,
    required bool isDark,
    required List<Widget> children,
    String? badge,
  }) {
    final isExpanded = expandedMenus.contains(menuKey);
    final activeColor = isDark ? AppColors.brandDark : AppColors.brand;

    if (isCollapsed) {
      return Tooltip(
        message: label,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            onTap: onToggle,
            borderRadius: AppDimensions.rMd,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 15,
                  color: isExpanded ? activeColor : theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
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
            onTap: onToggle,
            borderRadius: AppDimensions.rMd,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  FaIcon(
                    icon,
                    size: 15,
                    color: isExpanded ? activeColor : theme.textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.heading(
                        fontSize: 13,
                        fontWeight: isExpanded ? FontWeight.w600 : FontWeight.w500,
                        color: isExpanded ? activeColor : theme.colorScheme.onSurface,
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
                children: children,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubItem(
    String label,
    String pageKey,
    String selectedPage,
    NavigationNotifier navNotifier,
    bool isDrawer,
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
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
                style: AppTypography.body(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? activeColor : theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
