import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/login_params.freezed.dart';
part 'generated/login_params.g.dart';

@Freezed(toJson: true, fromJson: false)
abstract class LoginParams with _$LoginParams {
  @JsonSerializable(createToJson: true, createFactory: false)
  const factory LoginParams({
    required String username,
    required String password,
  }) = _LoginParams;
}
