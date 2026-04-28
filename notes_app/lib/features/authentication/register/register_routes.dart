import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/di/di.dart';
import 'package:notes_app/features/authentication/register/presentation/bloc/register_bloc.dart';
import 'package:notes_app/features/authentication/register/presentation/page/register_page.dart';

@lazySingleton
class RegisterRoutes extends BaseRoute {
  @override
  String get name => 'register';

  @override
  String get path => '/register';

  Future<T?> goToRegisterPage<T>(
    BuildContext context, {
    required NavigationType type,
  }) {
    return navigate(context, name: name, type: type);
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: path,
      name: name,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<RegisterBloc>(),
        child: RegisterPage(),
      ),
    ),
  ];
}
