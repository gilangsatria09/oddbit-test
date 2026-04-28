import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/register_params.freezed.dart';
part 'generated/register_params.g.dart';

@Freezed(toJson: true, fromJson: false)
abstract class RegisterParams with _$RegisterParams {
  @JsonSerializable(createToJson: true, createFactory: false)
  const factory RegisterParams({
    required String username,
    required String password,
  }) = _RegisterParams;
}
