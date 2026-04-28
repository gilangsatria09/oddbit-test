part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getNotes() = _GetNotes;
  const factory HomeEvent.createNote(PostNoteParams params) = _CreateNote;
  const factory HomeEvent.updateNote(UpdateNoteParams params) = _UpdateNote;
  const factory HomeEvent.deleteNote(int id) = _DeleteNote;
  const factory HomeEvent.getNote(int id) = _GetNote;
}
