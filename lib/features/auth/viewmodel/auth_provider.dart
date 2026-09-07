import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void setEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  Future<bool> signIn() async {
    if (state.email.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email address');
      return false;
    }
    if (state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your password');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate authentication delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false, isAuthenticated: true);
    return true;
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
