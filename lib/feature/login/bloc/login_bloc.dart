import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/base/service/base_service.dart';
import '../../../core/constants/enums/preferences_types.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../model/login_request.dart' show LoginRequest;
import '../service/login_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with BaseService {
  LoginBloc() : super(LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isValid) return;

      emit(state.copyWith(status: LoginStatus.submitting));

      try {
        final response = await LoginService().login(LoginRequest(email: state.email, password: state.password));

        if (response?.data != null) {
          final token = response?.data?.data?.token; // gelen token
          await LocaleManager.instance.setStringValue(PreferencesTypes.token, token ?? "");
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          emit(state.copyWith(status: LoginStatus.failure, error: "Invalid credentials"));
        }
      } catch (e) {
        emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
      }
    });
  }
}
