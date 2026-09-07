import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/forgot_password_state.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier() : super(const ForgotPasswordState());

  void setEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  Future<bool> sendResetLink() async {
    if (state.email.trim().isEmpty || !state.email.contains('@')) {
      state = state.copyWith(errorMessage: 'Please enter a valid email address');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate link dispatch
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false, isSent: true);
    return true;
  }

  void reset() {
    state = const ForgotPasswordState();
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  return ForgotPasswordNotifier();
});
