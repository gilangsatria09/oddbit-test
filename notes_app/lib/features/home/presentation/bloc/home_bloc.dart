import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/core/bloc/base_request_state.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/params/params.dart';
import 'package:notes_app/features/home/domain/usecases/usecases.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'generated/home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNotesUsecase _getNotesUsecase;
  final CreateNoteUsecase _createNoteUsecase;
  final UpdateNoteUsecase _updateNoteUsecase;
  final DeleteNoteUsecase _deleteNoteUsecase;
  final GetNoteUsecase _getNoteUsecase;

  HomeBloc(
    this._getNotesUsecase,
    this._createNoteUsecase,
    this._updateNoteUsecase,
    this._deleteNoteUsecase,
    this._getNoteUsecase,
  ) : super(HomeState.initial()) {
    on<_GetNotes>(_onGetNotes);
    on<_CreateNote>(_onCreateNote);
    on<_UpdateNote>(_onUpdateNote);
    on<_DeleteNote>(_onDeleteNote);
    on<_GetNote>(_onGetNote);
  }

  Future<void> _onGetNotes(_GetNotes event, Emitter<HomeState> emit) async {
    emit(state.copyWith(notesState: const RequestState.loading()));
    final result = await _getNotesUsecase(null);
    emit(
      state.copyWith(
        notesState: result.fold(
          (l) => RequestState.failed(l),
          (r) => RequestState.loaded(r),
        ),
      ),
    );
  }

  Future<void> _onCreateNote(_CreateNote event, Emitter<HomeState> emit) async {
    emit(state.copyWith(createState: const RequestState.loading()));
    final result = await _createNoteUsecase(event.params);
    emit(
      state.copyWith(
        createState: result.fold(
          (l) => RequestState.failed(l),
          (r) => RequestState.loaded(r),
        ),
      ),
    );
  }

  Future<void> _onUpdateNote(_UpdateNote event, Emitter<HomeState> emit) async {
    emit(state.copyWith(updateState: const RequestState.loading()));
    final result = await _updateNoteUsecase(event.params);
    emit(
      state.copyWith(
        updateState: result.fold(
          (l) => RequestState.failed(l),
          (r) => RequestState.loaded(r),
        ),
      ),
    );
  }

  Future<void> _onDeleteNote(_DeleteNote event, Emitter<HomeState> emit) async {
    emit(state.copyWith(deleteState: const RequestState.loading()));
    final result = await _deleteNoteUsecase(event.id);
    emit(
      state.copyWith(
        deleteState: result.fold(
          (l) => RequestState.failed(l),
          (r) => RequestState.loaded(r),
        ),
      ),
    );
  }

  Future<void> _onGetNote(_GetNote event, Emitter<HomeState> emit) async {
    emit(state.copyWith(noteState: const RequestState.loading()));
    final result = await _getNoteUsecase(event.id);
    emit(
      state.copyWith(
        noteState: result.fold(
          (l) => RequestState.failed(l),
          (r) => RequestState.loaded(r),
        ),
      ),
    );
  }
}
