class OtpState {
  final List<String> digits;
  final int resendCountdown;
  final bool canResend;
  final bool isLoading;
  final bool isVerified;
  final String? errorMessage;
  final String maskedEmail;

  const OtpState({
    this.digits = const ['', '', '', '', '', ''],
    this.resendCountdown = 30,
    this.canResend = false,
    this.isLoading = false,
    this.isVerified = false,
    this.errorMessage,
    this.maskedEmail = 'j••••@company.com',
  });

  String get code => digits.join();
  bool get isComplete => digits.length == 6 && digits.every((d) => d.isNotEmpty);

  OtpState copyWith({
    List<String>? digits,
    int? resendCountdown,
    bool? canResend,
    bool? isLoading,
    bool? isVerified,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? maskedEmail,
  }) {
    return OtpState(
      digits: digits ?? this.digits,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResend: canResend ?? this.canResend,
      isLoading: isLoading ?? this.isLoading,
      isVerified: isVerified ?? this.isVerified,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      maskedEmail: maskedEmail ?? this.maskedEmail,
    );
  }
}
