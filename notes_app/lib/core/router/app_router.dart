import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/di/di.dart';
import 'package:notes_app/features/authentication/login/login_routes.dart';
import 'package:notes_app/features/authentication/register/register_routes.dart';
import 'package:notes_app/features/home/home_route.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class AppRouter {
  static final LoginRoutes loginRoutes = getIt<LoginRoutes>();
  static final RegisterRoutes registerRoutes = getIt<RegisterRoutes>();
  static final HomeRoutes homeRoutes = getIt<HomeRoutes>();

  // static final authenticatedOnlyRoutes = [homeRoutes.path];

  // static final unauthenticatedOnlyRoutes = [
  //   splashRoutes.path,
  //   onboardingRoutes.path,
  //   ...authenticationRoutes.allFullPath,
  // ];

  static final GoRouter router = GoRouter(
    initialLocation: loginRoutes.path,
    observers: [routeObserver],
    routes: [
      ...loginRoutes.routes,
      ...registerRoutes.routes,
      ...homeRoutes.routes,
    ],
    debugLogDiagnostics: true,
  );
}
