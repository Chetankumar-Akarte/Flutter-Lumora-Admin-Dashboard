import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lumora/core/theme/app_theme.dart';
import 'package:flutter_lumora/features/auth/views/forgot_password_screen.dart';
import 'package:flutter_lumora/features/auth/views/lock_screen_screen.dart';
import 'package:flutter_lumora/features/auth/views/login_screen.dart';
import 'package:flutter_lumora/features/auth/views/register_screen.dart';
import 'package:flutter_lumora/features/auth/views/reset_password_screen.dart';
import 'package:flutter_lumora/features/auth/views/verify_otp_screen.dart';
import 'package:flutter_lumora/features/navigation/viewmodel/navigation_provider.dart';
import 'package:flutter_lumora/features/navigation/views/app_shell.dart';

void main() {
  testWidgets('LoginScreen renders hero section and login form on desktop', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('Run your business,\nbeautifully.'), findsOneWidget);
    expect(find.text('WELCOME BACK'), findsOneWidget);
    expect(find.text('Lightning-fast\nresponsive shell'), findsOneWidget);

    // Check Form elements
    expect(find.text('Sign in'), findsWidgets); // title and button
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Remember me for 30 days'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('Create one'), findsOneWidget);
  });

  testWidgets('AppShell navigates to LoginScreen and back', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: const AppShell(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Initially Dashboard
    expect(find.text('Overview'), findsOneWidget);

    // Switch to login
    container.read(navigationProvider.notifier).selectPage('login');
    await tester.pumpAndSettle();

    // Verify Login Screen is showing
    expect(find.text('Enter your details to access your dashboard.'), findsOneWidget);

    // Tap on Lumora brand in hero to return
    await tester.tap(find.text('Lumora').first);
    await tester.pumpAndSettle();

    // Back on dashboard
    expect(find.text('Overview'), findsOneWidget);
  });

  testWidgets('RegisterScreen renders fields, password meter and social buttons', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('Build your admin in minutes, not months.'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
    expect(find.text('Free 14-day\ntrial'), findsOneWidget);

    // Check Form elements
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('First name'), findsOneWidget);
    expect(find.text('Last name'), findsOneWidget);
    expect(find.text('Work email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);

    // Tap on Terms to open dialog
    await tester.tap(find.text('Terms'));
    await tester.pumpAndSettle();

    // Verify dialog opened with Legal Information and Terms content
    expect(find.text('Legal Information'), findsOneWidget);
    expect(find.text('1. Acceptance of Terms'), findsOneWidget);

    // Switch to Privacy Policy tab
    await tester.tap(find.text('Privacy Policy').last);
    await tester.pumpAndSettle();

    // Verify Privacy Policy content
    expect(find.text('1. Information We Collect'), findsOneWidget);

    // Tap Accept & Agree to close dialog and check agreement
    await tester.tap(find.text('Accept & Agree'));
    await tester.pumpAndSettle();

    // Dialog dismissed
    expect(find.text('Legal Information'), findsNothing);
  });

  testWidgets('ForgotPasswordScreen renders key icon, email input, and handles reset action', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ForgotPasswordScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('Forgot it happens\nto everyone.'), findsOneWidget);
    expect(find.text('RECOVERY'), findsOneWidget);

    // Check Form elements
    expect(find.text('Forgot your password?'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Send reset link'), findsOneWidget);
    expect(find.text('Back to sign in'), findsOneWidget);
    expect(find.text('Contact support'), findsOneWidget);

    // Tap Send reset link
    await tester.tap(find.text('Send reset link'));
    await tester.pumpAndSettle();

    // Verify success confirmation banner appears
    expect(
      find.text('Reset link sent! Please check your email inbox and spam folder for instructions.'),
      findsOneWidget,
    );
  });

  testWidgets('ResetPasswordScreen renders fields, live checklist, and handles reset action', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ResetPasswordScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('Choose a strong,\nmemorable password.'), findsOneWidget);
    expect(find.text('SET NEW PASSWORD'), findsOneWidget);

    // Check Form elements
    expect(find.text('Set a new password'), findsOneWidget);
    expect(find.text('New password'), findsOneWidget);
    expect(find.text('Confirm new password'), findsOneWidget);
    expect(find.text('At least 8 characters'), findsOneWidget);
    expect(find.text('Mix of upper & lower case'), findsOneWidget);
    expect(find.text('One number'), findsOneWidget);
    expect(find.text('One symbol'), findsOneWidget);
    expect(find.text('Reset password'), findsOneWidget);
    expect(find.text('Back to sign in'), findsOneWidget);

    // Tap Reset password
    await tester.tap(find.text('Reset password'));
    await tester.pumpAndSettle();

    // Verify success confirmation banner appears
    expect(
      find.text('Your password has been reset successfully! You can now sign in with your new credentials.'),
      findsOneWidget,
    );
  });

  testWidgets('VerifyOtpScreen renders 6-digit OTP cells, timer and handles verification', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: VerifyOtpScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('An extra layer of safety\nfor your account.'), findsOneWidget);
    expect(find.text('TWO-FACTOR'), findsOneWidget);

    // Check Form elements
    expect(find.text('Verify your identity'), findsOneWidget);
    expect(find.text('Verify and continue'), findsOneWidget);
    expect(find.text('Back to sign in'), findsOneWidget);

    // Tap Verify with empty fields -> should show error message
    await tester.tap(find.text('Verify and continue'));
    await tester.pump();
    expect(
      find.text('Please enter the complete 6-digit verification code'),
      findsOneWidget,
    );

    // Advance 2 seconds -> error message should STILL remain visible
    await tester.pump(const Duration(seconds: 2));
    expect(
      find.text('Please enter the complete 6-digit verification code'),
      findsOneWidget,
    );

    // Type digits into OTP fields
    final otpFields = find.byType(TextFormField);
    expect(otpFields, findsNWidgets(6));

    for (int i = 0; i < 6; i++) {
      await tester.enterText(otpFields.at(i), '${i + 1}');
    }
    await tester.pumpAndSettle();

    // Tap Verify and continue
    await tester.tap(find.text('Verify and continue'));
    await tester.pumpAndSettle();
  });

  testWidgets('LockScreenScreen renders user avatar, username and handles unlock', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LockScreenScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check Hero text
    expect(find.text('Welcome back,\nChetankumar.'), findsOneWidget);
    expect(find.text('SESSION LOCKED'), findsOneWidget);

    // Check Form elements
    expect(find.text('Chetankumar Akarte'), findsOneWidget);
    expect(find.text('Enter your password to unlock'), findsOneWidget);
    expect(find.text('Unlock'), findsOneWidget);
    expect(find.text('Sign in as different user'), findsOneWidget);

    // Tap Unlock
    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();
  });
}
