import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swagapp/modules/models/ui_models/pair.dart';

part 'async_value.freezed.dart';

@freezed
class AsyncValue<T> with _$AsyncValue<T> {
  const AsyncValue._();

  const factory AsyncValue.loaded(T data) = _Loaded<T>;

  const factory AsyncValue.loading([T? previousData]) = _Loading<T>;

  const factory AsyncValue.error(Object e, [T? previousData]) = _Error<T>;

  bool get isLoading => this is _Loading;

  bool get isLoadingWithoutPreviousData =>
      this is _Loading && (this as _Loading).previousData == null;

  bool get isLoaded => this is _Loaded;

  bool get isError => this is _Error;

  T? get dataOrPreviousData => this.when(
        loaded: (data) => data,
        loading: (previousData) => previousData,
        error: (e, previousData) => previousData,
      );
}

extension AsyncValueX<T> on AsyncValue<T> {
  AsyncValue<T> tryCopyWithDataOrPreviousData(T Function(T) copyWithFunc) {
    return when(
      loaded: (data) => AsyncValue.loaded(copyWithFunc(data)),
      loading: (previousData) => AsyncValue.loading(
          previousData == null ? null : copyWithFunc(previousData)),
      error: (e, previousData) => AsyncValue.error(
        e,
        previousData == null ? null : copyWithFunc(previousData),
      ),
    );
  }

  AsyncValue<Pair<T, U>> combineWith<U>(AsyncValue<U> another) {
    if (this.isError || another.isError) {
      var e = "";

      if (this.isError) {
        e += (this as _Error).e.toString();
      }

      if (another.isError) {
        e += (another as _Error).e.toString();
      }

      return AsyncValue.error(e);
    }

    if (this.isLoading || this.isLoading) {
      return const AsyncValue.loading();
    }

    return AsyncValue.loaded(Pair(
      this.dataOrPreviousData!,
      another.dataOrPreviousData!,
    ));
  }
}
