class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final bool isSent;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.isSent = false,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    bool? isSent,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      isSent: isSent ?? this.isSent,
      errorMessage: errorMessage,
    );
  }
}
