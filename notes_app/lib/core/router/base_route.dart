import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/router/router.dart';

abstract class BaseRoute {
  String get name;
  String get path;
  List<RouteBase> get routes;

  Future<T?> navigate<T>(
    BuildContext context, {
    required String name,
    required NavigationType type,
    Map<String, String> queryParameters = const {},
    Object? extra,
  }) {
    switch (type) {
      case NavigationType.goNamed:
        context.goNamed(name, queryParameters: queryParameters, extra: extra);
        return Future.value();
      case NavigationType.pushNamed:
        return context.pushNamed<T>(
          name,
          queryParameters: queryParameters,
          extra: extra,
        );
    }
  }
}
