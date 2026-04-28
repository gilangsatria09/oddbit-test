import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/post_note_params.freezed.dart';
part 'generated/post_note_params.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class PostNoteParams with _$PostNoteParams {
  @JsonSerializable(createFactory: false, createToJson: true)
  const factory PostNoteParams({
    required String title,
    required String content,
  }) = _PostNoteParams;
}
