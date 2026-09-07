import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/otp_state.dart';

class OtpNotifier extends StateNotifier<OtpState> {
  Timer? _timer;

  OtpNotifier() : super(const OtpState()) {
    startResendTimer();
  }

  void startResendTimer() {
    _timer?.cancel();
    state = state.copyWith(resendCountdown: 30, canResend: false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCountdown > 1) {
        state = state.copyWith(resendCountdown: state.resendCountdown - 1);
      } else {
        state = state.copyWith(resendCountdown: 0, canResend: true);
        timer.cancel();
      }
    });
  }

  void setDigit(int index, String value) {
    if (index < 0 || index >= 6) return;
    final updated = List<String>.from(state.digits);
    updated[index] = value;
    state = state.copyWith(digits: updated, clearErrorMessage: true);
  }

  void pasteCode(String code) {
    final cleanCode = code.replaceAll(RegExp(r'\D'), '');
    final updated = List<String>.filled(6, '');
    for (int i = 0; i < 6 && i < cleanCode.length; i++) {
      updated[i] = cleanCode[i];
    }
    state = state.copyWith(digits: updated, clearErrorMessage: true);
  }

  void clearCode() {
    state = state.copyWith(digits: const ['', '', '', '', '', ''], clearErrorMessage: true);
  }

  Future<bool> verifyCode() async {
    if (!state.isComplete) {
      state = state.copyWith(errorMessage: 'Please enter the complete 6-digit verification code');
      return false;
    }

    state = state.copyWith(isLoading: true, clearErrorMessage: true);

    // Simulate verification
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false, isVerified: true);
    return true;
  }

  void resendCode() {
    if (!state.canResend) return;
    clearCode();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final otpProvider = StateNotifierProvider.autoDispose<OtpNotifier, OtpState>((ref) {
  return OtpNotifier();
});
