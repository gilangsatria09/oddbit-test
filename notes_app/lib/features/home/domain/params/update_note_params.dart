import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/update_note_params.freezed.dart';
part 'generated/update_note_params.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class UpdateNoteParams with _$UpdateNoteParams {
  @JsonSerializable(createFactory: false, createToJson: true)
  const factory UpdateNoteParams({
    required int id,
    required String title,
    required String content,
  }) = _UpdateNoteParams;
}
