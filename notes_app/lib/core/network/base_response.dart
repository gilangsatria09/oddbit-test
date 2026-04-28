import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/core/logger/logger.dart';

part 'generated/base_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({int? statusCode, String? message, T? data}) =
      _BaseResponse<T>;

  const BaseResponse._();

  bool get isSuccess => statusCode == 200;

  static BaseResponse<List<T>> listFromJson<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    final data = json['data'];
    final list = (data is List)
        ? data
              .whereType<Map<String, dynamic>>()
              .map((item) {
                try {
                  return fromJsonT(item);
                } catch (e, s) {
                  logger.e(
                    'Error parsing item in listFromJson',
                    error: e,
                    stackTrace: s,
                  );
                  return null;
                }
              })
              .whereType<T>()
              .toList()
        : <T>[];

    return BaseResponse(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: list,
    );
  }

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return BaseResponse(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
