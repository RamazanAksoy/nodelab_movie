import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/register_request.dart';
import '../service/register_service.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<RegisterSubmitted>(_onSubmitted);
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordObscure: !(state.isPasswordObscure ?? false)));
    });
  }

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: RegisterStatus.submitting));

    try {
      if (state.password != state.confirmPassword) {
        emit(state.copyWith(status: RegisterStatus.failure, error: 'Passwords do not match'));
        return;
      }

      final request = RegisterRequest(email: state.email, name: state.name, password: state.password);

      final response = await RegisterService().register(request);

      if (response?.data != null) {
        emit(state.copyWith(status: RegisterStatus.success));
      } else {
        emit(state.copyWith(status: RegisterStatus.failure, error: 'Registration failed'));
      }
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure, error: e.toString()));
    }
  }
}
