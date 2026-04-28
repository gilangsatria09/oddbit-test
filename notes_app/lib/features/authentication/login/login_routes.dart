import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/di/di.dart';
import 'package:notes_app/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:notes_app/features/authentication/login/presentation/pages/login_page.dart';

@lazySingleton
class LoginRoutes extends BaseRoute {
  @override
  String get name => 'login';

  @override
  String get path => '/login';

  Future<T?> goToLoginPage<T>(
    BuildContext context, {
    NavigationType type = NavigationType.pushNamed,
  }) {
    return navigate(context, name: name, type: type);
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: path,
      name: name,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: const LoginPage(),
      ),
    ),
  ];
}
