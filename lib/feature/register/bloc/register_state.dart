enum RegisterStatus { initial, submitting, success, failure }

class RegisterState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final RegisterStatus status;
  final String? error;
  final bool? isPasswordObscure;

  RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = RegisterStatus.initial,
    this.error,
    this.isPasswordObscure,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    RegisterStatus? status,
    String? error,
    bool? isPasswordObscure,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      error: error,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
