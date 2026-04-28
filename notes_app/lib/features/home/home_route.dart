import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/di/di.dart';
import 'package:notes_app/core/pages/base_bottom_sheet_page.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:notes_app/features/home/presentation/pages/home_page.dart';
import 'package:notes_app/features/home/presentation/widgets/note_form_content.dart';
import 'package:notes_app/features/home/presentation/widgets/note_form_params.dart';

@lazySingleton
class HomeRoutes extends BaseRoute {
  @override
  String get name => 'home';
  String get noteCreateName => 'note_create';
  String get noteUpdateName => 'note_update';
  String get noteDetailName => 'note_detail';

  @override
  String get path => '/home';
  String get noteCreatePath => '/note/create';
  String get noteUpdatePath => '/note/update';
  String get noteDetailPath => '/note/detail';

  Future<T?> goToHomePage<T>(
    BuildContext context, {
    NavigationType type = NavigationType.goNamed,
  }) async {
    return navigate(context, name: name, type: type);
  }

  Future<T?> goToCreateNote<T>(
    BuildContext context, {
    Function(NoteEntity data)? onSubmitted,
    NavigationType type = NavigationType.pushNamed,
  }) async {
    return navigate(
      context,
      name: noteCreateName,
      type: type,
      extra: NoteFormParams(onSubmitted: onSubmitted),
    );
  }

  Future<T?> goToUpdateNote<T>(
    BuildContext context, {
    required NoteEntity note,
    Function(NoteEntity data)? onSubmitted,
    NavigationType type = NavigationType.pushNamed,
  }) async {
    return navigate(
      context,
      name: noteUpdateName,
      type: type,
      extra: NoteFormParams(note: note, onSubmitted: onSubmitted),
    );
  }

  Future<T?> goToDetailNote<T>(
    BuildContext context, {
    required NoteEntity note,
    NavigationType type = NavigationType.pushNamed,
  }) async {
    return navigate(
      context,
      name: noteDetailName,
      type: type,
      extra: NoteFormParams(note: note),
    );
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: path,
      name: name,
      builder: (context, state) =>
          BlocProvider(create: (_) => getIt<HomeBloc>(), child: HomePage()),
      routes: [
        GoRoute(
          path: noteCreatePath,
          name: noteCreateName,
          pageBuilder: (context, state) {
            final params = state.extra as NoteFormParams;
            return BaseBottomSheetPage.autoScroll(
              entity: AutoScrollBaseBottomSheetEntity(
                child: NoteFormContent(
                  mode: NoteFormMode.create,
                  onSubmitted: params.onSubmitted,
                ),
                config: BaseBottomSheetConfig(title: 'Create Note'),
              ),
            );
          },
        ),
        GoRoute(
          path: noteUpdatePath,
          name: noteUpdateName,
          pageBuilder: (context, state) {
            final params = state.extra as NoteFormParams;
            return BaseBottomSheetPage.autoScroll(
              entity: AutoScrollBaseBottomSheetEntity(
                child: NoteFormContent(
                  mode: NoteFormMode.update,
                  note: params.note,
                  onSubmitted: params.onSubmitted,
                ),
                config: BaseBottomSheetConfig(title: 'Update Note'),
              ),
            );
          },
        ),
        GoRoute(
          path: noteDetailPath,
          name: noteDetailName,
          pageBuilder: (context, state) {
            final params = state.extra as NoteFormParams;
            return BaseBottomSheetPage.autoScroll(
              entity: AutoScrollBaseBottomSheetEntity(
                child: NoteFormContent(
                  mode: NoteFormMode.detail,
                  note: params.note,
                ),
                config: BaseBottomSheetConfig(title: 'Note Detail'),
              ),
            );
          },
        ),
      ],
    ),
  ];
}
