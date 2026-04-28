import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/network/dio/dio_factory.dart';

@module
abstract class ClientModule {
  @Named(ClientModuleName.auth)
  Dio provideAuth(DioFactory factory) => factory.create(subPath: 'auth');
  @Named(ClientModuleName.notes)
  Dio provideNotes(DioFactory factory) => factory.create(subPath: 'notes');
}

class ClientModuleName {
  ClientModuleName._();

  static const String auth = 'authClientModule';
  static const String notes = 'notesClientModule';
}
