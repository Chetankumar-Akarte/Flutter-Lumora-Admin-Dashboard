class AuthState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isObscurePassword;
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;

  const AuthState({
    this.email = '',
    this.password = '',
    this.rememberMe = true,
    this.isObscurePassword = true,
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isObscurePassword,
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
