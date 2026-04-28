// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/api/notes/index.dart' as api_notes_index;
import '../routes/api/notes/[id].dart' as api_notes_$id;
import '../routes/api/auth/register.dart' as api_auth_register;
import '../routes/api/auth/login.dart' as api_auth_login;

import '../routes/_middleware.dart' as middleware;
import '../routes/api/notes/_middleware.dart' as api_notes_middleware;

void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/api/notes', (context) => buildApiNotesHandler()(context))
    ..mount('/api/auth', (context) => buildApiAuthHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildApiNotesHandler() {
  final pipeline = const Pipeline().addMiddleware(api_notes_middleware.middleware);
  final router = Router()
    ..all('/<id>', (context,id,) => api_notes_$id.onRequest(context,id,))..all('/', (context) => api_notes_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildApiAuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/login', (context) => api_auth_login.onRequest(context,))..all('/register', (context) => api_auth_register.onRequest(context,));
  return pipeline.addHandler(router);
}

