class RegisterState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool agreeToTerms;
  final bool isObscurePassword;
  final bool isLoading;
  final String? errorMessage;
  final int passwordStrength; // 0 to 4

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.agreeToTerms = false,
    this.isObscurePassword = true,
    this.isLoading = false,
    this.errorMessage,
    this.passwordStrength = 0,
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    bool? agreeToTerms,
    bool? isObscurePassword,
    bool? isLoading,
    String? errorMessage,
    int? passwordStrength,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      passwordStrength: passwordStrength ?? this.passwordStrength,
    );
  }
}
