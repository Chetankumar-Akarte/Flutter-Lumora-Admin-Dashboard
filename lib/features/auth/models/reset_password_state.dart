class ResetPasswordState {
  final String newPassword;
  final String confirmPassword;
  final bool isObscureNewPassword;
  final bool isObscureConfirmPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final int passwordStrength; // 0 to 4
  final bool hasMinLength;
  final bool hasMixedCase;
  final bool hasNumber;
  final bool hasSymbol;

  const ResetPasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isObscureNewPassword = true,
    this.isObscureConfirmPassword = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.passwordStrength = 0,
    this.hasMinLength = false,
    this.hasMixedCase = false,
    this.hasNumber = false,
    this.hasSymbol = false,
  });

  ResetPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isObscureNewPassword,
    bool? isObscureConfirmPassword,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    int? passwordStrength,
    bool? hasMinLength,
    bool? hasMixedCase,
    bool? hasNumber,
    bool? hasSymbol,
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasMixedCase: hasMixedCase ?? this.hasMixedCase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSymbol: hasSymbol ?? this.hasSymbol,
    );
  }
}
