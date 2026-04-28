import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    required int statusCode,
  }) = ServerFailure;

  const factory Failure.connection(String message) = ConnectionFailure;
  const factory Failure.timeout(String message) = TimeoutFailure;
  const factory Failure.unauthenticated(String message) =
      UnauthenticatedFailure;
  const factory Failure.unexpected(String message) = UnexpectedFailure;
}
