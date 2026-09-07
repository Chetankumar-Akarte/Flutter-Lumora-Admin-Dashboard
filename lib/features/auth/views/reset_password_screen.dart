import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../navigation/viewmodel/navigation_provider.dart';
import '../viewmodel/reset_password_provider.dart';
import 'widgets/auth_hero_section.dart';
import 'widgets/password_strength_meter.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(resetPasswordProvider);
    _newPasswordController = TextEditingController(text: state.newPassword.isEmpty ? 'LumoraPass2026!' : state.newPassword);
    _confirmPasswordController = TextEditingController(text: state.confirmPassword.isEmpty ? 'LumoraPass2026!' : state.confirmPassword);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(resetPasswordProvider.notifier);
      notifier.setNewPassword(_newPasswordController.text);
      notifier.setConfirmPassword(_confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    final notifier = ref.read(resetPasswordProvider.notifier);
    notifier.setNewPassword(_newPasswordController.text);
    notifier.setConfirmPassword(_confirmPasswordController.text);

    final success = await notifier.resetPassword();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has been successfully updated!'),
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
                    eyebrowIcon: FontAwesomeIcons.shieldHalved,
                    eyebrowText: 'SET NEW PASSWORD',
                    title: 'Choose a strong,\nmemorable password.',
                    subtitle:
                        'Make it long, mix character types, and never reuse a password from another account.',
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
    final state = ref.watch(resetPasswordProvider);
    final notifier = ref.read(resetPasswordProvider.notifier);

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

            const SizedBox(height: 32),

            // Form Wrapper (Centered with max-width 420px)
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Subtitle
                      Text(
                        'Set a new password',
                        style: AppTypography.heading(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Your new password must be different from previously used passwords.',
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Success Confirmation Banner
                      if (state.isSuccess) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.12),
                            borderRadius: AppDimensions.rMd,
                            border: Border.all(
                              color: AppColors.success.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  size: 15,
                                  color: AppColors.success,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Your password has been reset successfully! You can now sign in with your new credentials.",
                                  style: AppTypography.body(
                                    fontSize: 13,
                                    color: isDark ? AppColors.successDark : AppColors.success,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],

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

                      // Field 1: New Password
                      Text(
                        'New password',
                        style: AppTypography.heading(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: state.isObscureNewPassword,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (val) => notifier.setNewPassword(val),
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: '••••••••',
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
                                  state.isObscureNewPassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 14,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                onPressed: () => notifier.toggleNewPasswordVisibility(),
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
                      const SizedBox(height: 8),

                      // Password Strength Meter
                      PasswordStrengthMeter(strength: state.passwordStrength),
                      const SizedBox(height: 16),

                      // Field 2: Confirm New Password
                      Text(
                        'Confirm new password',
                        style: AppTypography.heading(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: state.isObscureConfirmPassword,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (val) => notifier.setConfirmPassword(val),
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: '••••••••',
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
                                  state.isObscureConfirmPassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 14,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                onPressed: () => notifier.toggleConfirmPasswordVisibility(),
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
                      const SizedBox(height: 16),

                      // Live Requirement Checklist
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                          borderRadius: AppDimensions.rMd,
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildRuleItem('At least 8 characters', state.hasMinLength, theme),
                            const SizedBox(height: 6),
                            _buildRuleItem('Mix of upper & lower case', state.hasMixedCase, theme),
                            const SizedBox(height: 6),
                            _buildRuleItem('One number', state.hasNumber, theme),
                            const SizedBox(height: 6),
                            _buildRuleItem('One symbol', state.hasSymbol, theme),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Reset Password Button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: state.isLoading ? null : _handleResetPassword,
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
                                  'Reset password',
                                  style: AppTypography.heading(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Back to Sign In Ghost Button
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                size: 13,
                                color: theme.colorScheme.onSurface,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Back to sign in',
                                style: AppTypography.heading(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
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

  Widget _buildRuleItem(String text, bool isSatisfied, ThemeData theme) {
    return Row(
      children: [
        FaIcon(
          isSatisfied ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
          size: 13,
          color: isSatisfied
              ? AppColors.success
              : theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTypography.body(
            fontSize: 12,
            fontWeight: isSatisfied ? FontWeight.w600 : FontWeight.w400,
            color: isSatisfied
                ? theme.colorScheme.onSurface
                : theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
