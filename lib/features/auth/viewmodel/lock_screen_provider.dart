import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lock_screen_state.dart';

class LockScreenNotifier extends StateNotifier<LockScreenState> {
  LockScreenNotifier() : super(const LockScreenState());

  void setPassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  Future<bool> unlock() async {
    if (state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your password to unlock');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate unlock delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false, isUnlocked: true);
    return true;
  }

  void reset() {
    state = const LockScreenState();
  }
}

final lockScreenProvider =
    StateNotifierProvider.autoDispose<LockScreenNotifier, LockScreenState>((ref) {
  return LockScreenNotifier();
});
