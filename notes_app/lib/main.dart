import 'package:flutter/material.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/di/di.dart';
import 'package:notes_app/shared_ui/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDepedencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
