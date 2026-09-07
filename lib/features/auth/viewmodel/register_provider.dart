import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(const RegisterState());

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName, errorMessage: null);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName, errorMessage: null);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void setPassword(String password) {
    final strength = _calculatePasswordStrength(password);
    state = state.copyWith(
      password: password,
      passwordStrength: strength,
      errorMessage: null,
    );
  }

  void toggleAgreeToTerms() {
    state = state.copyWith(agreeToTerms: !state.agreeToTerms, errorMessage: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  int _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    return score;
  }

  Future<bool> createAccount() async {
    if (state.firstName.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your first name');
      return false;
    }
    if (state.lastName.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your last name');
      return false;
    }
    if (state.email.trim().isEmpty || !state.email.contains('@')) {
      state = state.copyWith(errorMessage: 'Please enter a valid work email');
      return false;
    }
    if (state.password.length < 8) {
      state = state.copyWith(errorMessage: 'Password must be at least 8 characters');
      return false;
    }
    if (!state.agreeToTerms) {
      state = state.copyWith(errorMessage: 'Please accept the Terms & Privacy Policy');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate account creation delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false);
    return true;
  }

  void reset() {
    state = const RegisterState();
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier();
});
