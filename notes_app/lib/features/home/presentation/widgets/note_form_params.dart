import 'package:notes_app/features/home/domain/entities/note_entity.dart';

class NoteFormParams {
  final NoteEntity? note;
  final Function(NoteEntity data)? onSubmitted;

  const NoteFormParams({this.note, this.onSubmitted});
}
