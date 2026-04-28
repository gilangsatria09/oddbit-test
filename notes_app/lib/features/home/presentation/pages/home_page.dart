import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/home/domain/params/params.dart';
import 'package:notes_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:notes_app/gen/assets.gen.dart';
import 'package:notes_app/shared_ui/theme/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePage<HomePage> {
  late HomeBloc _homeBloc;
  int? _updatingNoteId;
  int? _deletingNoteId;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();

    _homeBloc.add(HomeEvent.getNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            state.createState.maybeWhen(
              loaded: (data) {
                _homeBloc.add(HomeEvent.getNotes());
              },
              orElse: () => null,
            );
          },
          listenWhen: (previous, current) =>
              previous.createState != current.createState,
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            state.noteState.maybeWhen(
              loaded: (data) {
                AppRouter.homeRoutes.goToDetailNote(context, note: data);
              },
              orElse: () => null,
            );
          },
          listenWhen: (previous, current) =>
              previous.noteState != current.noteState,
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            state.updateState.maybeWhen(
              loaded: (_) {
                _homeBloc.add(HomeEvent.getNotes());
                setState(() => _updatingNoteId = null);
              },
              failed: (_) => setState(() => _updatingNoteId = null),
              orElse: () => null,
            );
          },
          listenWhen: (previous, current) =>
              previous.updateState != current.updateState,
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            state.deleteState.maybeWhen(
              loaded: (message) {
                _homeBloc.add(HomeEvent.getNotes());
                showSnackBar(message);
                setState(() => _deletingNoteId = null);
              },
              failed: (_) => setState(() => _deletingNoteId = null),
              orElse: () => null,
            );
          },
          listenWhen: (previous, current) =>
              previous.deleteState != current.deleteState,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            spacing: 16,
            children: [
              Assets.images.png.notepad.image(width: 24, height: 24),
              Text('YourNotes'),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.createState != current.createState,
          builder: (context, state) {
            final isLoading = state.createState.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            return FloatingActionButton(
              onPressed: isLoading
                  ? null
                  : () {
                      AppRouter.homeRoutes.goToCreateNote(
                        context,
                        onSubmitted: (data) {
                          _homeBloc.add(
                            HomeEvent.createNote(
                              PostNoteParams(
                                title: data.title,
                                content: data.content,
                              ),
                            ),
                          );
                          context.pop();
                        },
                      );
                    },
              shape: CircleBorder(),
              child: isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2.5,
                      ),
                    )
                  : Icon(Icons.add),
            );
          },
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.notesState.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          initial: () => const SizedBox.shrink(),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          loaded: (notes) {
            if (notes.isEmpty) {
              return Center(
                child: Text(
                  'No notes found',
                  style: AppTextStyle.headings.h6.medium.textStyle,
                ),
              );
            }
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _updatingNoteId == note.id &&
                              state.updateState.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              )
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2.5,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                AppRouter.homeRoutes.goToUpdateNote(
                                  context,
                                  note: note,
                                  onSubmitted: (data) {
                                    setState(() => _updatingNoteId = note.id);
                                    _homeBloc.add(
                                      HomeEvent.updateNote(
                                        UpdateNoteParams(
                                          id: note.id,
                                          title: data.title,
                                          content: data.content,
                                        ),
                                      ),
                                    );
                                    context.pop();
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit, color: Colors.teal),
                            ),
                      _deletingNoteId == note.id &&
                              state.deleteState.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              )
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2.5,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() => _deletingNoteId = note.id);
                                _homeBloc.add(HomeEvent.deleteNote(note.id));
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                    ],
                  ),
                  onTap: () {
                    _homeBloc.add(HomeEvent.getNote(note.id));
                  },
                );
              },
            );
          },
          failed: (failure) => Center(child: Text(failure.message)),
        );
      },
    );
  }
}
