import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.height,
    this.textAlignVertical,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;
  final double? height;
  final TextAlignVertical? textAlignVertical;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      onChanged: onChanged,
      expands: height != null,
      maxLines: height != null ? null : 1,
      decoration: InputDecoration(hintText: hintText, errorText: errorText),
      textAlignVertical: textAlignVertical,
      readOnly: readOnly,
    );

    if (height != null) {
      return SizedBox(height: height, child: field);
    }

    return field;
  }
}
