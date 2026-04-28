import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T>
    with AfterLayoutMixin<T> {
  @override
  void afterFirstLayout(BuildContext context) {}

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : null,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
