class LockScreenState {
  final String password;
  final bool isObscurePassword;
  final bool isLoading;
  final bool isUnlocked;
  final String? errorMessage;
  final String userName;
  final String avatarUrl;

  const LockScreenState({
    this.password = '',
    this.isObscurePassword = true,
    this.isLoading = false,
    this.isUnlocked = false,
    this.errorMessage,
    this.userName = 'Chetankumar Akarte',
    this.avatarUrl = 'https://avatars.githubusercontent.com/u/27378345?v=4',
  });

  LockScreenState copyWith({
    String? password,
    bool? isObscurePassword,
    bool? isLoading,
    bool? isUnlocked,
    String? errorMessage,
    String? userName,
    String? avatarUrl,
  }) {
    return LockScreenState(
      password: password ?? this.password,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isLoading: isLoading ?? this.isLoading,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      errorMessage: errorMessage,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
