import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/avatar_badge.dart';
import '../../navigation/viewmodel/navigation_provider.dart';
import '../viewmodel/lock_screen_provider.dart';
import 'widgets/auth_hero_section.dart';

class LockScreenScreen extends ConsumerStatefulWidget {
  const LockScreenScreen({super.key});

  @override
  ConsumerState<LockScreenScreen> createState() => _LockScreenScreenState();
}

class _LockScreenScreenState extends ConsumerState<LockScreenScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(lockScreenProvider);
    _passwordController = TextEditingController(text: state.password.isEmpty ? 'password123' : state.password);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lockScreenProvider.notifier).setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _handleUnlock() async {
    final notifier = ref.read(lockScreenProvider.notifier);
    notifier.setPassword(_passwordController.text);

    final success = await notifier.unlock();
    if (success && mounted) {
      ref.read(navigationProvider.notifier).selectPage('dashboard');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session unlocked! Welcome back, Chetankumar.'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth >= 992;

          if (isWideScreen) {
            return Row(
              children: [
                // Left Hero Section (approx 1.05fr)
                Expanded(
                  flex: 11,
                  child: AuthHeroSection(
                    eyebrowIcon: FontAwesomeIcons.lock,
                    eyebrowText: 'SESSION LOCKED',
                    title: 'Welcome back,\nChetankumar.',
                    subtitle:
                        'For your security, we locked your session after a period of inactivity. Enter your password to pick up right where you left off.',
                    features: const [],
                    onBrandTap: () {
                      ref.read(navigationProvider.notifier).selectPage('dashboard');
                    },
                  ),
                ),

                // Right Form Section (approx 1fr)
                Expanded(
                  flex: 10,
                  child: _buildFormPanel(context, isDark, showBrand: false),
                ),
              ],
            );
          }

          // Mobile / Tablet: Single Column
          return _buildFormPanel(context, isDark, showBrand: true);
        },
      ),
    );
  }

  Widget _buildFormPanel(BuildContext context, bool isDark, {required bool showBrand}) {
    final theme = Theme.of(context);
    final themeNotifier = ref.read(themeModeProvider.notifier);
    final state = ref.watch(lockScreenProvider);
    final notifier = ref.read(lockScreenProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Header: Brand (Mobile only) + Theme Toggle (Always)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBrand)
                  InkWell(
                    onTap: () {
                      ref.read(navigationProvider.notifier).selectPage('dashboard');
                    },
                    borderRadius: AppDimensions.rMd,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5B5BF7), Color(0xFFA855F7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: AppDimensions.rMd,
                          ),
                          child: const Center(
                            child: Text(
                              'L',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Lumora',
                          style: AppTypography.heading(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox.shrink(),

                // Theme Toggle Icon Button
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: AppDimensions.rMd,
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                      size: 15,
                      color: theme.colorScheme.onSurface,
                    ),
                    tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    onPressed: () => themeNotifier.toggleTheme(),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // Centered Lock Screen Form (max-width 400px)
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Avatar with Online Indicator
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? AppColors.darkBorderStrong : AppColors.lightBorderStrong,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.brand.withValues(alpha: 0.15),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: AvatarBadge(
                          imageUrl: state.avatarUrl,
                          size: 80,
                          isOnline: true,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // User Name
                      Text(
                        state.userName,
                        textAlign: TextAlign.center,
                        style: AppTypography.heading(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Subtitle
                      Text(
                        'Enter your password to unlock',
                        textAlign: TextAlign.center,
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Error message banner if any
                      if (state.errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withValues(alpha: 0.12),
                            borderRadius: AppDimensions.rMd,
                            border: Border.all(
                              color: AppColors.danger.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.circleExclamation,
                                size: 14,
                                color: AppColors.danger,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  state.errorMessage!,
                                  style: AppTypography.body(
                                    fontSize: 13,
                                    color: AppColors.danger,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: state.isObscurePassword,
                        textAlignVertical: TextAlignVertical.center,
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: AppTypography.body(
                            fontSize: 14,
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                          prefixIcon: SizedBox(
                            width: 44,
                            height: 44,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.lock,
                                size: 14,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 44,
                            maxHeight: 44,
                          ),
                          suffixIcon: SizedBox(
                            width: 44,
                            height: 44,
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                icon: FaIcon(
                                  state.isObscurePassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 14,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                onPressed: () => notifier.togglePasswordVisibility(),
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 44,
                            maxHeight: 44,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          filled: true,
                          fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                          border: OutlineInputBorder(
                            borderRadius: AppDimensions.rMd,
                            borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: AppDimensions.rMd,
                            borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: AppDimensions.rMd,
                            borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Unlock Button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: state.isLoading ? null : _handleUnlock,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brand,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: AppColors.brand.withValues(alpha: 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rMd,
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Unlock',
                                  style: AppTypography.heading(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Sign in as different user
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: TextButton(
                          onPressed: () {
                            ref.read(navigationProvider.notifier).selectPage('login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rMd,
                            ),
                          ),
                          child: Text(
                            'Sign in as different user',
                            style: AppTypography.heading(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Bottom Footer
            Center(
              child: Text(
                '© 2026 Lumora',
                style: AppTypography.body(
                  fontSize: 12,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
