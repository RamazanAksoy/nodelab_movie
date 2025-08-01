abstract class RegisterEvent {}

class NameChanged extends RegisterEvent {
  final String name;
  NameChanged(this.name);
}

class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class RegisterSubmitted extends RegisterEvent {}

class TogglePasswordVisibility extends RegisterEvent {}
