import 'package:flutter/material.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/shared_ui/shared_ui.dart';

enum NoteFormMode { create, update, detail }

class NoteFormContent extends StatefulWidget {
  final NoteFormMode mode;
  final NoteEntity? note;
  final Function(NoteEntity data)? onSubmitted;

  const NoteFormContent({
    super.key,
    required this.mode,
    this.note,
    this.onSubmitted,
  });

  @override
  State<NoteFormContent> createState() => _NoteFormContentState();
}

class _NoteFormContentState extends State<NoteFormContent> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  String? _titleError;
  String? _contentError;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _contentController = TextEditingController(text: widget.note?.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool _validate() {
    final titleEmpty = _titleController.text.trim().isEmpty;
    final contentEmpty = _contentController.text.trim().isEmpty;
    setState(() {
      _titleError = titleEmpty ? 'Title is required' : null;
      _contentError = contentEmpty ? 'Content is required' : null;
    });
    return !titleEmpty && !contentEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = widget.mode == NoteFormMode.detail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        AppTextField(
          hintText: 'Title',
          controller: _titleController,
          errorText: _titleError,
          readOnly: readOnly,
        ),
        AppTextField(
          hintText: 'Content',
          height: 200,
          textAlignVertical: TextAlignVertical.top,
          controller: _contentController,
          errorText: _contentError,
          readOnly: readOnly,
        ),
        if (widget.mode != NoteFormMode.detail)
          AppFilledButton(
            label: widget.mode == NoteFormMode.create
                ? 'Create Note'
                : 'Update Note',
            onPressed: () {
              if (!_validate()) return;
              widget.onSubmitted?.call(
                NoteEntity(
                  title: _titleController.text,
                  content: _contentController.text,
                ),
              );
            },
          ),
      ],
    );
  }
}
