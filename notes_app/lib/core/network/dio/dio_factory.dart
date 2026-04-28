import 'package:dio/dio.dart';

abstract class DioFactory {
  Dio create({required String subPath});
}
