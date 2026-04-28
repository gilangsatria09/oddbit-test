import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/core/errors/failure.dart';

part 'generated/base_request_state.freezed.dart';

@freezed
sealed class RequestState<T> with _$RequestState<T> {
  const factory RequestState.initial() = _Initial;
  const factory RequestState.loading() = _Loading;
  const factory RequestState.loaded(T data) = _Loaded;
  const factory RequestState.failed(Failure failure) = _Failed;
}
