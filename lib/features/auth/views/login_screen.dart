import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../navigation/viewmodel/navigation_provider.dart';
import '../viewmodel/auth_provider.dart';
import 'widgets/auth_hero_section.dart';
import 'widgets/auth_social_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    _emailController = TextEditingController(text: authState.email.isEmpty ? 'you@company.com' : authState.email);
    _passwordController = TextEditingController(text: authState.password.isEmpty ? 'password123' : authState.password);

    // Synchronize initial controller state to notifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).setEmail(_emailController.text);
      ref.read(authProvider.notifier).setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose;
    _passwordController.dispose;
    super.dispose();
  }

  void _handleSignIn() async {
    final authNotifier = ref.read(authProvider.notifier);
    authNotifier.setEmail(_emailController.text);
    authNotifier.setPassword(_passwordController.text);

    final success = await authNotifier.signIn();
    if (success && mounted) {
      ref.read(navigationProvider.notifier).selectPage('dashboard');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully signed in! Welcome to Lumora.'),
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
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

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
                        'Sign in',
                        style: AppTypography.heading(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Enter your details to access your dashboard.',
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Error message banner if any
                      if (authState.errorMessage != null) ...[
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
                                  authState.errorMessage!,
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

                      // Email Field
                      Text(
                        'Email address',
                        style: AppTypography.heading(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.center,
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'you@company.com',
                          hintStyle: AppTypography.body(
                            fontSize: 14,
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                          prefixIcon: SizedBox(
                            width: 44,
                            height: 44,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.envelope,
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
                      const SizedBox(height: 18),

                      // Password Field + Forgot Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password',
                            style: AppTypography.heading(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(navigationProvider.notifier).selectPage('forgot-password');
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              child: Text(
                                'Forgot?',
                                style: AppTypography.heading(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brand,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: authState.isObscurePassword,
                        textAlignVertical: TextAlignVertical.center,
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
                                  authState.isObscurePassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 14,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                onPressed: () => authNotifier.togglePasswordVisibility(),
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

                      // Remember Me Checkbox
                      InkWell(
                        onTap: () => authNotifier.toggleRememberMe(),
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: authState.rememberMe,
                                  onChanged: (_) => authNotifier.toggleRememberMe(),
                                  activeColor: AppColors.brand,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember me for 30 days',
                                style: AppTypography.body(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: authState.isLoading ? null : _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brand,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: AppColors.brand.withValues(alpha: 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rMd,
                            ),
                          ),
                          child: authState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Sign in',
                                  style: AppTypography.heading(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'or continue with',
                              style: AppTypography.body(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Social Buttons
                      Row(
                        children: [
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.google,
                              onPressed: () => _handleSocialLogin('Google'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.apple,
                              onPressed: () => _handleSocialLogin('Apple'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.github,
                              onPressed: () => _handleSocialLogin('GitHub'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Bottom Footer Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTypography.body(
                    fontSize: 13,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(navigationProvider.notifier).selectPage('register');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Create one',
                      style: AppTypography.heading(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.brand,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signing in with $provider...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
