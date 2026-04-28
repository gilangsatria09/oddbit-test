import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/note_entity.freezed.dart';
part 'generated/note_entity.g.dart';

@freezed
abstract class NoteEntity with _$NoteEntity {
  const factory NoteEntity({
    @Default(-1) int id,
    @Default('') String title,
    @Default('') String content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoteEntity;

  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);
}
