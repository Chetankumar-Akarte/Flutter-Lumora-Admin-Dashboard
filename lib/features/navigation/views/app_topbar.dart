import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/avatar_badge.dart';
import '../viewmodel/navigation_provider.dart';

class AppTopbar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;

  const AppTopbar({super.key, this.onMenuPressed});

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.topbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);
    final navNotifier = ref.read(navigationProvider.notifier);

    return Container(
      height: AppDimensions.topbarHeight,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      child: Row(
        children: [
          // Sidebar Toggle Button
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: theme.colorScheme.onSurface,
            tooltip: 'Toggle Navigation',
            onPressed: () {
              if (isMobile) {
                onMenuPressed?.call();
              } else {
                navNotifier.toggleSidebar();
              }
            },
          ),
          const SizedBox(width: 8),

          // Search Field (Desktop & Tablet)
          if (!isMobile)
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: SizedBox(
                  height: 38,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search anything...',
                      hintStyle: AppTypography.body(
                        fontSize: 13,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 18,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      filled: true,
                      fillColor: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: AppDimensions.rMd,
                        borderSide: BorderSide(color: theme.colorScheme.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppDimensions.rMd,
                        borderSide: BorderSide(color: theme.colorScheme.outline),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            const Spacer(),

          if (!isMobile) const Spacer(),

          // Dark / Light Mode Toggle Button
          IconButton(
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            icon: FaIcon(
              isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
              size: 15,
              color: isDark ? const Color(0xFFFBBF24) : theme.textTheme.bodyMedium?.color,
            ),
            onPressed: () => themeModeNotifier.toggleTheme(),
          ),
          const SizedBox(width: 2),

          // 1. Notification Bell with Dropdown Menu
          PopupMenuButton<String>(
            tooltip: 'Notifications',
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.rLg,
              side: BorderSide(color: theme.colorScheme.outline),
            ),
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            itemBuilder: (context) => [
              // Header
              PopupMenuItem(
                enabled: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notifications',
                      style: AppTypography.heading(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
                        borderRadius: AppDimensions.rPill,
                      ),
                      child: Text(
                        '4 new',
                        style: AppTypography.heading(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.brandDark : AppColors.brand,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              // Notification 1
              PopupMenuItem(
                value: 'notif_1',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.successDarkSoft : AppColors.successSoft,
                        borderRadius: AppDimensions.rMd,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.circleCheck,
                          size: 14,
                          color: isDark ? AppColors.successDark : AppColors.success,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Completed',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Order #12345 has been shipped',
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '2 minutes ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Notification 2
              PopupMenuItem(
                value: 'notif_2',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.warnDarkSoft : AppColors.warnSoft,
                        borderRadius: AppDimensions.rMd,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.triangleExclamation,
                          size: 14,
                          color: isDark ? AppColors.warnDark : AppColors.warn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Low Stock Alert',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '5 items left in inventory',
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '1 hour ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Notification 3
              PopupMenuItem(
                value: 'notif_3',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.infoDarkSoft : AppColors.infoSoft,
                        borderRadius: AppDimensions.rMd,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.userPlus,
                          size: 14,
                          color: isDark ? AppColors.infoDark : AppColors.info,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New User Joined',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Sarah Anderson registered',
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '3 hours ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Notification 4
              PopupMenuItem(
                value: 'notif_4',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.dangerDarkSoft : AppColors.dangerSoft,
                        borderRadius: AppDimensions.rMd,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          size: 14,
                          color: isDark ? AppColors.dangerDark : AppColors.danger,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Failed',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Order #12346 payment declined',
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '5 hours ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              // Footer
              PopupMenuItem(
                value: 'view_all_notifs',
                child: Center(
                  child: Text(
                    'View all notifications',
                    style: AppTypography.heading(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.brandDark : AppColors.brand,
                    ),
                  ),
                ),
              ),
            ],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: FaIcon(
                    FontAwesomeIcons.bell,
                    size: 15,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),

          // 2. Messages Envelope with Dropdown Menu
          PopupMenuButton<String>(
            tooltip: 'Messages',
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.rLg,
              side: BorderSide(color: theme.colorScheme.outline),
            ),
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            itemBuilder: (context) => [
              // Header
              PopupMenuItem(
                enabled: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Messages',
                      style: AppTypography.heading(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.brandDarkSoft : AppColors.brandSoft,
                        borderRadius: AppDimensions.rPill,
                      ),
                      child: Text(
                        '3 new',
                        style: AppTypography.heading(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.brandDark : AppColors.brand,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              // Message 1
              PopupMenuItem(
                value: 'msg_1',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AvatarBadge(
                      imageUrl: 'https://i.pravatar.cc/64?img=8',
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alex Rivera',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Thanks for the quick response...',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '10 minutes ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Message 2
              PopupMenuItem(
                value: 'msg_2',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AvatarBadge(
                      imageUrl: 'https://i.pravatar.cc/64?img=15',
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jordan Chen',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Can we schedule a call today?',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '45 minutes ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Message 3
              PopupMenuItem(
                value: 'msg_3',
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AvatarBadge(
                      imageUrl: 'https://i.pravatar.cc/64?img=22',
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emma Wilson',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Check the updated proposal',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body(
                              fontSize: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '2 hours ago',
                            style: AppTypography.body(
                              fontSize: 10,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              // Footer
              PopupMenuItem(
                value: 'view_all_msgs',
                child: Center(
                  child: Text(
                    'View all messages',
                    style: AppTypography.heading(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.brandDark : AppColors.brand,
                    ),
                  ),
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(8),
              child: FaIcon(
                FontAwesomeIcons.envelope,
                size: 15,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // 3. User Profile Dropdown Pill
          PopupMenuButton<String>(
            offset: const Offset(0, 52),
            shape: RoundedRectangleBorder(
              borderRadius: AppDimensions.rLg,
              side: BorderSide(color: theme.colorScheme.outline),
            ),
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            onSelected: (val) {
              if (val == 'dark_mode') {
                themeModeNotifier.toggleTheme();
              }
            },
            itemBuilder: (context) => [
              // Header Card
              PopupMenuItem(
                enabled: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chetankumar Akarte',
                      style: AppTypography.heading(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Senior Solution Architect',
                      style: AppTypography.body(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              // Profile Items
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.circleUser, size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 12),
                    Text('My Profile', style: AppTypography.body(fontSize: 13, color: theme.colorScheme.onSurface)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.gear, size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 12),
                    Text('Settings', style: AppTypography.body(fontSize: 13, color: theme.colorScheme.onSurface)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'billing',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.creditCard, size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 12),
                    Text('Billing', style: AppTypography.body(fontSize: 13, color: theme.colorScheme.onSurface)),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              PopupMenuItem(
                value: 'dark_mode',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.moon, size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 12),
                    Text('Dark Mode', style: AppTypography.body(fontSize: 13, color: theme.colorScheme.onSurface)),
                    const Spacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.brandDark : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'help',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.circleQuestion, size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 12),
                    Text('Help & Support', style: AppTypography.body(fontSize: 13, color: theme.colorScheme.onSurface)),
                  ],
                ),
              ),
              const PopupMenuDivider(),

              PopupMenuItem(
                value: 'sign_out',
                child: Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.rightFromBracket, size: 14, color: AppColors.danger),
                    const SizedBox(width: 12),
                    Text(
                      'Sign Out',
                      style: AppTypography.heading(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 4 : 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: AppDimensions.rPill,
                border: isMobile ? null : Border.all(color: theme.colorScheme.outline),
              ),
              child: Row(
                children: [
                  const AvatarBadge(
                    imageUrl: 'https://avatars.githubusercontent.com/u/27378345?v=4',
                    size: 32,
                    isOnline: true,
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chetankumar Akarte',
                          style: AppTypography.heading(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'Senior Solution Architect',
                          style: AppTypography.body(
                            fontSize: 10,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
