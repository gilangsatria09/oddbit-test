import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/core/bloc/base_request_state.dart';
import 'package:notes_app/features/authentication/register/domain/params/register_params.dart';
import 'package:notes_app/features/authentication/register/domain/usecases/register_usecase.dart';
import 'package:notes_app/shared_ui/extensions/string_validator_extension.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'generated/register_bloc.freezed.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _register;

  RegisterBloc(this._register) : super(RegisterState.initial()) {
    on<_Register>((event, emit) async {
      emit(state.copyWith(registerState: RequestState.loading()));

      final request = await _register(event.params);

      request.fold(
        (l) => emit(state.copyWith(registerState: RequestState.failed(l))),
        (r) => emit(state.copyWith(registerState: RequestState.loaded(null))),
      );
    });
    on<_UsernameChanged>(
      (event, emit) => emit(
        state.copyWith(
          username: event.value,
          usernameError: event.value.validateFormatUsername(),
        ),
      ),
    );
    on<_PasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          password: event.value,
          passwordError: event.value.validateFormatPassword(),
        ),
      ),
    );
    on<_ConfirmPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          confirmPassword: event.value,
          confirmPasswordError: event.value != state.password
              ? 'Password does not match!'
              : null,
        ),
      ),
    );
  }
}
