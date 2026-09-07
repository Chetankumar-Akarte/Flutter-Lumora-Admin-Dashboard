import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reset_password_state.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  ResetPasswordNotifier() : super(const ResetPasswordState());

  void setNewPassword(String password) {
    final hasMinLength = password.length >= 8;
    final hasMixedCase = password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int strength = 0;
    if (password.isNotEmpty) {
      if (hasMinLength) strength++;
      if (hasMixedCase) strength++;
      if (hasNumber) strength++;
      if (hasSymbol) strength++;
    }

    state = state.copyWith(
      newPassword: password,
      passwordStrength: strength,
      hasMinLength: hasMinLength,
      hasMixedCase: hasMixedCase,
      hasNumber: hasNumber,
      hasSymbol: hasSymbol,
      errorMessage: null,
    );
  }

  void setConfirmPassword(String password) {
    state = state.copyWith(confirmPassword: password, errorMessage: null);
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(isObscureNewPassword: !state.isObscureNewPassword);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(isObscureConfirmPassword: !state.isObscureConfirmPassword);
  }

  Future<bool> resetPassword() async {
    if (state.newPassword.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter a new password');
      return false;
    }
    if (!state.hasMinLength || !state.hasMixedCase || !state.hasNumber || !state.hasSymbol) {
      state = state.copyWith(errorMessage: 'Please satisfy all password complexity requirements');
      return false;
    }
    if (state.confirmPassword.isEmpty) {
      state = state.copyWith(errorMessage: 'Please confirm your new password');
      return false;
    }
    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(errorMessage: 'Passwords do not match');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate reset delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false, isSuccess: true);
    return true;
  }

  void reset() {
    state = const ResetPasswordState();
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>((ref) {
  return ResetPasswordNotifier();
});
