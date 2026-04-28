part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default(RequestState.initial()) RequestState<String> loginState,
    @Default('') String username,
    String? usernameError,
    @Default('') String password,
    String? passwordError,
  }) = _LoginState;

  factory LoginState.initial() => LoginState();

  bool get canLogin => username.isNotEmpty && password.isNotEmpty;
}
