part of 'register_bloc.dart';

@freezed
abstract class RegisterState with _$RegisterState {
  const RegisterState._();

  const factory RegisterState({
    @Default(RequestState.initial()) RequestState registerState,
    @Default('') String username,
    String? usernameError,
    @Default('') String password,
    String? passwordError,
    @Default('') String confirmPassword,
    String? confirmPasswordError,
  }) = _RegisterState;

  factory RegisterState.initial() => RegisterState();

  bool get canRegister =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      usernameError == null &&
      passwordError == null &&
      confirmPasswordError == null;
}
