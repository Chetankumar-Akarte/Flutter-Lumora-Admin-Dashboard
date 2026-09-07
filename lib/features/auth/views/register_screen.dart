import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../navigation/viewmodel/navigation_provider.dart';
import '../viewmodel/register_provider.dart';
import 'widgets/auth_hero_section.dart';
import 'widgets/auth_social_button.dart';
import 'widgets/password_strength_meter.dart';
import 'widgets/terms_and_privacy_dialog.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(registerProvider);
    _firstNameController = TextEditingController(text: state.firstName.isEmpty ? 'Jane' : state.firstName);
    _lastNameController = TextEditingController(text: state.lastName.isEmpty ? 'Cooper' : state.lastName);
    _emailController = TextEditingController(text: state.email.isEmpty ? 'jane@company.com' : state.email);
    _passwordController = TextEditingController(text: state.password.isEmpty ? 'SecurePass123!' : state.password);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(registerProvider.notifier);
      notifier.setFirstName(_firstNameController.text);
      notifier.setLastName(_lastNameController.text);
      notifier.setEmail(_emailController.text);
      notifier.setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final notifier = ref.read(registerProvider.notifier);
    notifier.setFirstName(_firstNameController.text);
    notifier.setLastName(_lastNameController.text);
    notifier.setEmail(_emailController.text);
    notifier.setPassword(_passwordController.text);

    final success = await notifier.createAccount();
    if (success && mounted) {
      ref.read(navigationProvider.notifier).selectPage('dashboard');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Welcome to Lumora.'),
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
                    eyebrowIcon: FontAwesomeIcons.rocket,
                    eyebrowText: 'GET STARTED',
                    title: 'Build your admin in minutes, not months.',
                    subtitle:
                        'Create your free workspace and invite your team. No credit card required, cancel anytime.',
                    features: const [
                      AuthHeroFeatureItem(
                        icon: FontAwesomeIcons.check,
                        label: 'Free 14-day\ntrial',
                      ),
                      AuthHeroFeatureItem(
                        icon: FontAwesomeIcons.check,
                        label: 'Unlimited\nteam seats',
                      ),
                      AuthHeroFeatureItem(
                        icon: FontAwesomeIcons.check,
                        label: 'Priority\nsupport',
                      ),
                      AuthHeroFeatureItem(
                        icon: FontAwesomeIcons.check,
                        label: 'Cancel\nanytime',
                      ),
                    ],
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
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);

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

            const SizedBox(height: 28),

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
                        'Create your account',
                        style: AppTypography.heading(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Start your 14-day free trial. No credit card required.',
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Error message banner if any
                      if (registerState.errorMessage != null) ...[
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
                                  registerState.errorMessage!,
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

                      // First Name & Last Name Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First name',
                                  style: AppTypography.heading(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _firstNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: AppTypography.body(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Jane',
                                    hintStyle: AppTypography.body(
                                      fontSize: 14,
                                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
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
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last name',
                                  style: AppTypography.heading(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _lastNameController,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: AppTypography.body(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Cooper',
                                    hintStyle: AppTypography.body(
                                      fontSize: 14,
                                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Work Email Field
                      Text(
                        'Work email',
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
                          hintText: 'jane@company.com',
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
                      const SizedBox(height: 16),

                      // Password Field + Toggle + Strength Meter
                      Text(
                        'Password',
                        style: AppTypography.heading(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: registerState.isObscurePassword,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (val) => registerNotifier.setPassword(val),
                        style: AppTypography.body(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'At least 8 characters',
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
                                  registerState.isObscurePassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 14,
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                                onPressed: () => registerNotifier.togglePasswordVisibility(),
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
                      PasswordStrengthMeter(strength: registerState.passwordStrength),
                      const SizedBox(height: 6),

                      // Password Hint
                      Text(
                        'Use 8+ characters with a mix of letters, numbers and symbols.',
                        style: AppTypography.body(
                          fontSize: 12,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Agree to Terms Checkbox
                      InkWell(
                        onTap: () => registerNotifier.toggleAgreeToTerms(),
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: registerState.agreeToTerms,
                                  onChanged: (_) => registerNotifier.toggleAgreeToTerms(),
                                  activeColor: AppColors.brand,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'I agree to the ',
                                      style: AppTypography.body(
                                        fontSize: 13,
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        TermsAndPrivacyDialog.show(
                                          context,
                                          initialDocument: LegalDocumentType.terms,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                        child: Text(
                                          'Terms',
                                          style: AppTypography.heading(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.brand,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' and ',
                                      style: AppTypography.body(
                                        fontSize: 13,
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        TermsAndPrivacyDialog.show(
                                          context,
                                          initialDocument: LegalDocumentType.privacy,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                        child: Text(
                                          'Privacy Policy',
                                          style: AppTypography.heading(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.brand,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '.',
                                      style: AppTypography.body(
                                        fontSize: 13,
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: registerState.isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brand,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: AppColors.brand.withValues(alpha: 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.rMd,
                            ),
                          ),
                          child: registerState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Create account',
                                  style: AppTypography.heading(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),

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
                              'or sign up with',
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
                      const SizedBox(height: 18),

                      // Social Buttons
                      Row(
                        children: [
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.google,
                              onPressed: () => _handleSocialSignUp('Google'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.apple,
                              onPressed: () => _handleSocialSignUp('Apple'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AuthSocialButton(
                              type: AuthSocialType.github,
                              onPressed: () => _handleSocialSignUp('GitHub'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Bottom Footer Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: AppTypography.body(
                    fontSize: 13,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(navigationProvider.notifier).selectPage('login');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Sign in',
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

  void _handleSocialSignUp(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signing up with $provider...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
