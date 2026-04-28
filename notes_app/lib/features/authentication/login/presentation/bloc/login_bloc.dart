import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/authentication/login/domain/params/params.dart';
import 'package:notes_app/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:notes_app/shared_ui/extensions/string_validator_extension.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'generated/login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _login;

  LoginBloc(this._login) : super(LoginState.initial()) {
    on<_Login>((event, emit) async {
      emit(state.copyWith(loginState: RequestState.loading()));

      final request = await _login(event.params);

      request.fold(
        (l) => emit(state.copyWith(loginState: RequestState.failed(l))),
        (r) => emit(state.copyWith(loginState: RequestState.loaded(r))),
      );
    });
    on<_UsernameChanged>(
      (event, emit) => emit(
        state.copyWith(
          username: event.value,
          usernameError: event.value.validateEmptyUsername(),
        ),
      ),
    );
    on<_PasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          password: event.value,
          passwordError: event.value.validateEmptyPassword(),
        ),
      ),
    );
  }
}
