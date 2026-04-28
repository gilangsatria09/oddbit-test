part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(RequestState.initial()) RequestState<List<NoteEntity>> notesState,
    @Default(RequestState.initial()) RequestState<NoteEntity> noteState,
    @Default(RequestState.initial()) RequestState<String> deleteState,
    @Default(RequestState.initial()) RequestState<NoteEntity> createState,
    @Default(RequestState.initial()) RequestState<NoteEntity> updateState,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState();
}
