part of 'login_bloc.dart';

@freezed
abstract class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login(LoginParams params) = _Login;
  const factory LoginEvent.usernameChanged(String value) = _UsernameChanged;
  const factory LoginEvent.passwordChanged(String value) = _PasswordChanged;
}
