enum LoginStatus { initial, submitting, success, failure }

class LoginState {
  final String email;
  final String password;
  final LoginStatus status;
  final String? error;
  final bool isPasswordObscure;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState({this.email = '', this.password = '', this.status = LoginStatus.initial, this.error, this.isPasswordObscure = true});

  LoginState copyWith({String? email, String? password, LoginStatus? status, String? error, bool? isPasswordObscure}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
