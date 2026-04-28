part of 'register_bloc.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.register(RegisterParams params) = _Register;
  const factory RegisterEvent.usernameChanged(String value) = _UsernameChanged;
  const factory RegisterEvent.passwordChanged(String value) = _PasswordChanged;
  const factory RegisterEvent.confirmPasswordChanged(String value) =
      _ConfirmPasswordChanged;
}
