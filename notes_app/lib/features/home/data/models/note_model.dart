import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';

part 'generated/note_model.freezed.dart';
part 'generated/note_model.g.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const NoteModel._();

  const factory NoteModel({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  NoteEntity toEntity() {
    return NoteEntity(
      id: id ?? -1,
      title: title ?? '',
      content: content ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
