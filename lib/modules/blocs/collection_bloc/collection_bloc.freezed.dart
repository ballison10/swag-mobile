// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CollectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCollectionItem,
    required TResult Function(AddCollectionModel model) addCollection,
    required TResult Function(AddCollectionModel model) removeCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCollectionItem,
    TResult? Function(AddCollectionModel model)? addCollection,
    TResult? Function(AddCollectionModel model)? removeCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCollectionItem,
    TResult Function(AddCollectionModel model)? addCollection,
    TResult Function(AddCollectionModel model)? removeCollection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollectionItem value) getCollectionItem,
    required TResult Function(_CollectionEvent value) addCollection,
    required TResult Function(_RemoveCollectionEvent value) removeCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollectionItem value)? getCollectionItem,
    TResult? Function(_CollectionEvent value)? addCollection,
    TResult? Function(_RemoveCollectionEvent value)? removeCollection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollectionItem value)? getCollectionItem,
    TResult Function(_CollectionEvent value)? addCollection,
    TResult Function(_RemoveCollectionEvent value)? removeCollection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionEventCopyWith<$Res> {
  factory $CollectionEventCopyWith(
          CollectionEvent value, $Res Function(CollectionEvent) then) =
      _$CollectionEventCopyWithImpl<$Res, CollectionEvent>;
}

/// @nodoc
class _$CollectionEventCopyWithImpl<$Res, $Val extends CollectionEvent>
    implements $CollectionEventCopyWith<$Res> {
  _$CollectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_GetCollectionItemCopyWith<$Res> {
  factory _$$_GetCollectionItemCopyWith(_$_GetCollectionItem value,
          $Res Function(_$_GetCollectionItem) then) =
      __$$_GetCollectionItemCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GetCollectionItemCopyWithImpl<$Res>
    extends _$CollectionEventCopyWithImpl<$Res, _$_GetCollectionItem>
    implements _$$_GetCollectionItemCopyWith<$Res> {
  __$$_GetCollectionItemCopyWithImpl(
      _$_GetCollectionItem _value, $Res Function(_$_GetCollectionItem) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_GetCollectionItem implements _GetCollectionItem {
  const _$_GetCollectionItem();

  @override
  String toString() {
    return 'CollectionEvent.getCollectionItem()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_GetCollectionItem);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCollectionItem,
    required TResult Function(AddCollectionModel model) addCollection,
    required TResult Function(AddCollectionModel model) removeCollection,
  }) {
    return getCollectionItem();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCollectionItem,
    TResult? Function(AddCollectionModel model)? addCollection,
    TResult? Function(AddCollectionModel model)? removeCollection,
  }) {
    return getCollectionItem?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCollectionItem,
    TResult Function(AddCollectionModel model)? addCollection,
    TResult Function(AddCollectionModel model)? removeCollection,
    required TResult orElse(),
  }) {
    if (getCollectionItem != null) {
      return getCollectionItem();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollectionItem value) getCollectionItem,
    required TResult Function(_CollectionEvent value) addCollection,
    required TResult Function(_RemoveCollectionEvent value) removeCollection,
  }) {
    return getCollectionItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollectionItem value)? getCollectionItem,
    TResult? Function(_CollectionEvent value)? addCollection,
    TResult? Function(_RemoveCollectionEvent value)? removeCollection,
  }) {
    return getCollectionItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollectionItem value)? getCollectionItem,
    TResult Function(_CollectionEvent value)? addCollection,
    TResult Function(_RemoveCollectionEvent value)? removeCollection,
    required TResult orElse(),
  }) {
    if (getCollectionItem != null) {
      return getCollectionItem(this);
    }
    return orElse();
  }
}

abstract class _GetCollectionItem implements CollectionEvent {
  const factory _GetCollectionItem() = _$_GetCollectionItem;
}

/// @nodoc
abstract class _$$_CollectionEventCopyWith<$Res> {
  factory _$$_CollectionEventCopyWith(
          _$_CollectionEvent value, $Res Function(_$_CollectionEvent) then) =
      __$$_CollectionEventCopyWithImpl<$Res>;
  @useResult
  $Res call({AddCollectionModel model});

  $AddCollectionModelCopyWith<$Res> get model;
}

/// @nodoc
class __$$_CollectionEventCopyWithImpl<$Res>
    extends _$CollectionEventCopyWithImpl<$Res, _$_CollectionEvent>
    implements _$$_CollectionEventCopyWith<$Res> {
  __$$_CollectionEventCopyWithImpl(
      _$_CollectionEvent _value, $Res Function(_$_CollectionEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$_CollectionEvent(
      null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as AddCollectionModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AddCollectionModelCopyWith<$Res> get model {
    return $AddCollectionModelCopyWith<$Res>(_value.model, (value) {
      return _then(_value.copyWith(model: value));
    });
  }
}

/// @nodoc

class _$_CollectionEvent implements _CollectionEvent {
  const _$_CollectionEvent(this.model);

  @override
  final AddCollectionModel model;

  @override
  String toString() {
    return 'CollectionEvent.addCollection(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectionEvent &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CollectionEventCopyWith<_$_CollectionEvent> get copyWith =>
      __$$_CollectionEventCopyWithImpl<_$_CollectionEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCollectionItem,
    required TResult Function(AddCollectionModel model) addCollection,
    required TResult Function(AddCollectionModel model) removeCollection,
  }) {
    return addCollection(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCollectionItem,
    TResult? Function(AddCollectionModel model)? addCollection,
    TResult? Function(AddCollectionModel model)? removeCollection,
  }) {
    return addCollection?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCollectionItem,
    TResult Function(AddCollectionModel model)? addCollection,
    TResult Function(AddCollectionModel model)? removeCollection,
    required TResult orElse(),
  }) {
    if (addCollection != null) {
      return addCollection(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollectionItem value) getCollectionItem,
    required TResult Function(_CollectionEvent value) addCollection,
    required TResult Function(_RemoveCollectionEvent value) removeCollection,
  }) {
    return addCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollectionItem value)? getCollectionItem,
    TResult? Function(_CollectionEvent value)? addCollection,
    TResult? Function(_RemoveCollectionEvent value)? removeCollection,
  }) {
    return addCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollectionItem value)? getCollectionItem,
    TResult Function(_CollectionEvent value)? addCollection,
    TResult Function(_RemoveCollectionEvent value)? removeCollection,
    required TResult orElse(),
  }) {
    if (addCollection != null) {
      return addCollection(this);
    }
    return orElse();
  }
}

abstract class _CollectionEvent implements CollectionEvent {
  const factory _CollectionEvent(final AddCollectionModel model) =
      _$_CollectionEvent;

  AddCollectionModel get model;
  @JsonKey(ignore: true)
  _$$_CollectionEventCopyWith<_$_CollectionEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RemoveCollectionEventCopyWith<$Res> {
  factory _$$_RemoveCollectionEventCopyWith(_$_RemoveCollectionEvent value,
          $Res Function(_$_RemoveCollectionEvent) then) =
      __$$_RemoveCollectionEventCopyWithImpl<$Res>;
  @useResult
  $Res call({AddCollectionModel model});

  $AddCollectionModelCopyWith<$Res> get model;
}

/// @nodoc
class __$$_RemoveCollectionEventCopyWithImpl<$Res>
    extends _$CollectionEventCopyWithImpl<$Res, _$_RemoveCollectionEvent>
    implements _$$_RemoveCollectionEventCopyWith<$Res> {
  __$$_RemoveCollectionEventCopyWithImpl(_$_RemoveCollectionEvent _value,
      $Res Function(_$_RemoveCollectionEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$_RemoveCollectionEvent(
      null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as AddCollectionModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AddCollectionModelCopyWith<$Res> get model {
    return $AddCollectionModelCopyWith<$Res>(_value.model, (value) {
      return _then(_value.copyWith(model: value));
    });
  }
}

/// @nodoc

class _$_RemoveCollectionEvent implements _RemoveCollectionEvent {
  const _$_RemoveCollectionEvent(this.model);

  @override
  final AddCollectionModel model;

  @override
  String toString() {
    return 'CollectionEvent.removeCollection(model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoveCollectionEvent &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoveCollectionEventCopyWith<_$_RemoveCollectionEvent> get copyWith =>
      __$$_RemoveCollectionEventCopyWithImpl<_$_RemoveCollectionEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCollectionItem,
    required TResult Function(AddCollectionModel model) addCollection,
    required TResult Function(AddCollectionModel model) removeCollection,
  }) {
    return removeCollection(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCollectionItem,
    TResult? Function(AddCollectionModel model)? addCollection,
    TResult? Function(AddCollectionModel model)? removeCollection,
  }) {
    return removeCollection?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCollectionItem,
    TResult Function(AddCollectionModel model)? addCollection,
    TResult Function(AddCollectionModel model)? removeCollection,
    required TResult orElse(),
  }) {
    if (removeCollection != null) {
      return removeCollection(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCollectionItem value) getCollectionItem,
    required TResult Function(_CollectionEvent value) addCollection,
    required TResult Function(_RemoveCollectionEvent value) removeCollection,
  }) {
    return removeCollection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCollectionItem value)? getCollectionItem,
    TResult? Function(_CollectionEvent value)? addCollection,
    TResult? Function(_RemoveCollectionEvent value)? removeCollection,
  }) {
    return removeCollection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCollectionItem value)? getCollectionItem,
    TResult Function(_CollectionEvent value)? addCollection,
    TResult Function(_RemoveCollectionEvent value)? removeCollection,
    required TResult orElse(),
  }) {
    if (removeCollection != null) {
      return removeCollection(this);
    }
    return orElse();
  }
}

abstract class _RemoveCollectionEvent implements CollectionEvent {
  const factory _RemoveCollectionEvent(final AddCollectionModel model) =
      _$_RemoveCollectionEvent;

  AddCollectionModel get model;
  @JsonKey(ignore: true)
  _$$_RemoveCollectionEventCopyWith<_$_RemoveCollectionEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CollectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(AddCollectionModel successCollection)
        loadedCollectionSuccess,
    required TResult Function(List<CatalogItemModel> dataCollectionlList)
        loadedCollectionItems,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult? Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCollectionState value) initial,
    required TResult Function(_ErrorCollectionState value) error,
    required TResult Function(LoadedSuccessCollection value)
        loadedCollectionSuccess,
    required TResult Function(LoadedCollectionItemState value)
        loadedCollectionItems,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCollectionState value)? initial,
    TResult? Function(_ErrorCollectionState value)? error,
    TResult? Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult? Function(LoadedCollectionItemState value)? loadedCollectionItems,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCollectionState value)? initial,
    TResult Function(_ErrorCollectionState value)? error,
    TResult Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult Function(LoadedCollectionItemState value)? loadedCollectionItems,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionStateCopyWith<$Res> {
  factory $CollectionStateCopyWith(
          CollectionState value, $Res Function(CollectionState) then) =
      _$CollectionStateCopyWithImpl<$Res, CollectionState>;
}

/// @nodoc
class _$CollectionStateCopyWithImpl<$Res, $Val extends CollectionState>
    implements $CollectionStateCopyWith<$Res> {
  _$CollectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCollectionStateCopyWith<$Res> {
  factory _$$_InitialCollectionStateCopyWith(_$_InitialCollectionState value,
          $Res Function(_$_InitialCollectionState) then) =
      __$$_InitialCollectionStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCollectionStateCopyWithImpl<$Res>
    extends _$CollectionStateCopyWithImpl<$Res, _$_InitialCollectionState>
    implements _$$_InitialCollectionStateCopyWith<$Res> {
  __$$_InitialCollectionStateCopyWithImpl(_$_InitialCollectionState _value,
      $Res Function(_$_InitialCollectionState) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_InitialCollectionState extends _InitialCollectionState {
  _$_InitialCollectionState() : super._();

  @override
  String toString() {
    return 'CollectionState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InitialCollectionState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(AddCollectionModel successCollection)
        loadedCollectionSuccess,
    required TResult Function(List<CatalogItemModel> dataCollectionlList)
        loadedCollectionItems,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult? Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCollectionState value) initial,
    required TResult Function(_ErrorCollectionState value) error,
    required TResult Function(LoadedSuccessCollection value)
        loadedCollectionSuccess,
    required TResult Function(LoadedCollectionItemState value)
        loadedCollectionItems,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCollectionState value)? initial,
    TResult? Function(_ErrorCollectionState value)? error,
    TResult? Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult? Function(LoadedCollectionItemState value)? loadedCollectionItems,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCollectionState value)? initial,
    TResult Function(_ErrorCollectionState value)? error,
    TResult Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult Function(LoadedCollectionItemState value)? loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialCollectionState extends CollectionState {
  factory _InitialCollectionState() = _$_InitialCollectionState;
  _InitialCollectionState._() : super._();
}

/// @nodoc
abstract class _$$_ErrorCollectionStateCopyWith<$Res> {
  factory _$$_ErrorCollectionStateCopyWith(_$_ErrorCollectionState value,
          $Res Function(_$_ErrorCollectionState) then) =
      __$$_ErrorCollectionStateCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorCollectionStateCopyWithImpl<$Res>
    extends _$CollectionStateCopyWithImpl<$Res, _$_ErrorCollectionState>
    implements _$$_ErrorCollectionStateCopyWith<$Res> {
  __$$_ErrorCollectionStateCopyWithImpl(_$_ErrorCollectionState _value,
      $Res Function(_$_ErrorCollectionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ErrorCollectionState(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorCollectionState extends _ErrorCollectionState {
  _$_ErrorCollectionState(this.message) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'CollectionState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorCollectionState &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCollectionStateCopyWith<_$_ErrorCollectionState> get copyWith =>
      __$$_ErrorCollectionStateCopyWithImpl<_$_ErrorCollectionState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(AddCollectionModel successCollection)
        loadedCollectionSuccess,
    required TResult Function(List<CatalogItemModel> dataCollectionlList)
        loadedCollectionItems,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult? Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCollectionState value) initial,
    required TResult Function(_ErrorCollectionState value) error,
    required TResult Function(LoadedSuccessCollection value)
        loadedCollectionSuccess,
    required TResult Function(LoadedCollectionItemState value)
        loadedCollectionItems,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCollectionState value)? initial,
    TResult? Function(_ErrorCollectionState value)? error,
    TResult? Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult? Function(LoadedCollectionItemState value)? loadedCollectionItems,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCollectionState value)? initial,
    TResult Function(_ErrorCollectionState value)? error,
    TResult Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult Function(LoadedCollectionItemState value)? loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorCollectionState extends CollectionState {
  factory _ErrorCollectionState(final String message) = _$_ErrorCollectionState;
  _ErrorCollectionState._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorCollectionStateCopyWith<_$_ErrorCollectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedSuccessCollectionCopyWith<$Res> {
  factory _$$LoadedSuccessCollectionCopyWith(_$LoadedSuccessCollection value,
          $Res Function(_$LoadedSuccessCollection) then) =
      __$$LoadedSuccessCollectionCopyWithImpl<$Res>;
  @useResult
  $Res call({AddCollectionModel successCollection});

  $AddCollectionModelCopyWith<$Res> get successCollection;
}

/// @nodoc
class __$$LoadedSuccessCollectionCopyWithImpl<$Res>
    extends _$CollectionStateCopyWithImpl<$Res, _$LoadedSuccessCollection>
    implements _$$LoadedSuccessCollectionCopyWith<$Res> {
  __$$LoadedSuccessCollectionCopyWithImpl(_$LoadedSuccessCollection _value,
      $Res Function(_$LoadedSuccessCollection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successCollection = null,
  }) {
    return _then(_$LoadedSuccessCollection(
      null == successCollection
          ? _value.successCollection
          : successCollection // ignore: cast_nullable_to_non_nullable
              as AddCollectionModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AddCollectionModelCopyWith<$Res> get successCollection {
    return $AddCollectionModelCopyWith<$Res>(_value.successCollection, (value) {
      return _then(_value.copyWith(successCollection: value));
    });
  }
}

/// @nodoc

class _$LoadedSuccessCollection extends LoadedSuccessCollection {
  _$LoadedSuccessCollection(this.successCollection) : super._();

  @override
  final AddCollectionModel successCollection;

  @override
  String toString() {
    return 'CollectionState.loadedCollectionSuccess(successCollection: $successCollection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedSuccessCollection &&
            (identical(other.successCollection, successCollection) ||
                other.successCollection == successCollection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, successCollection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedSuccessCollectionCopyWith<_$LoadedSuccessCollection> get copyWith =>
      __$$LoadedSuccessCollectionCopyWithImpl<_$LoadedSuccessCollection>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(AddCollectionModel successCollection)
        loadedCollectionSuccess,
    required TResult Function(List<CatalogItemModel> dataCollectionlList)
        loadedCollectionItems,
  }) {
    return loadedCollectionSuccess(successCollection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult? Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
  }) {
    return loadedCollectionSuccess?.call(successCollection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (loadedCollectionSuccess != null) {
      return loadedCollectionSuccess(successCollection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCollectionState value) initial,
    required TResult Function(_ErrorCollectionState value) error,
    required TResult Function(LoadedSuccessCollection value)
        loadedCollectionSuccess,
    required TResult Function(LoadedCollectionItemState value)
        loadedCollectionItems,
  }) {
    return loadedCollectionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCollectionState value)? initial,
    TResult? Function(_ErrorCollectionState value)? error,
    TResult? Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult? Function(LoadedCollectionItemState value)? loadedCollectionItems,
  }) {
    return loadedCollectionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCollectionState value)? initial,
    TResult Function(_ErrorCollectionState value)? error,
    TResult Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult Function(LoadedCollectionItemState value)? loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (loadedCollectionSuccess != null) {
      return loadedCollectionSuccess(this);
    }
    return orElse();
  }
}

abstract class LoadedSuccessCollection extends CollectionState {
  factory LoadedSuccessCollection(final AddCollectionModel successCollection) =
      _$LoadedSuccessCollection;
  LoadedSuccessCollection._() : super._();

  AddCollectionModel get successCollection;
  @JsonKey(ignore: true)
  _$$LoadedSuccessCollectionCopyWith<_$LoadedSuccessCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedCollectionItemStateCopyWith<$Res> {
  factory _$$LoadedCollectionItemStateCopyWith(
          _$LoadedCollectionItemState value,
          $Res Function(_$LoadedCollectionItemState) then) =
      __$$LoadedCollectionItemStateCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CatalogItemModel> dataCollectionlList});
}

/// @nodoc
class __$$LoadedCollectionItemStateCopyWithImpl<$Res>
    extends _$CollectionStateCopyWithImpl<$Res, _$LoadedCollectionItemState>
    implements _$$LoadedCollectionItemStateCopyWith<$Res> {
  __$$LoadedCollectionItemStateCopyWithImpl(_$LoadedCollectionItemState _value,
      $Res Function(_$LoadedCollectionItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataCollectionlList = null,
  }) {
    return _then(_$LoadedCollectionItemState(
      dataCollectionlList: null == dataCollectionlList
          ? _value._dataCollectionlList
          : dataCollectionlList // ignore: cast_nullable_to_non_nullable
              as List<CatalogItemModel>,
    ));
  }
}

/// @nodoc

class _$LoadedCollectionItemState extends LoadedCollectionItemState {
  _$LoadedCollectionItemState(
      {required final List<CatalogItemModel> dataCollectionlList})
      : _dataCollectionlList = dataCollectionlList,
        super._();

  final List<CatalogItemModel> _dataCollectionlList;
  @override
  List<CatalogItemModel> get dataCollectionlList {
    if (_dataCollectionlList is EqualUnmodifiableListView)
      return _dataCollectionlList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataCollectionlList);
  }

  @override
  String toString() {
    return 'CollectionState.loadedCollectionItems(dataCollectionlList: $dataCollectionlList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedCollectionItemState &&
            const DeepCollectionEquality()
                .equals(other._dataCollectionlList, _dataCollectionlList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_dataCollectionlList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedCollectionItemStateCopyWith<_$LoadedCollectionItemState>
      get copyWith => __$$LoadedCollectionItemStateCopyWithImpl<
          _$LoadedCollectionItemState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(AddCollectionModel successCollection)
        loadedCollectionSuccess,
    required TResult Function(List<CatalogItemModel> dataCollectionlList)
        loadedCollectionItems,
  }) {
    return loadedCollectionItems(dataCollectionlList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult? Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
  }) {
    return loadedCollectionItems?.call(dataCollectionlList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(AddCollectionModel successCollection)?
        loadedCollectionSuccess,
    TResult Function(List<CatalogItemModel> dataCollectionlList)?
        loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (loadedCollectionItems != null) {
      return loadedCollectionItems(dataCollectionlList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialCollectionState value) initial,
    required TResult Function(_ErrorCollectionState value) error,
    required TResult Function(LoadedSuccessCollection value)
        loadedCollectionSuccess,
    required TResult Function(LoadedCollectionItemState value)
        loadedCollectionItems,
  }) {
    return loadedCollectionItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialCollectionState value)? initial,
    TResult? Function(_ErrorCollectionState value)? error,
    TResult? Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult? Function(LoadedCollectionItemState value)? loadedCollectionItems,
  }) {
    return loadedCollectionItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialCollectionState value)? initial,
    TResult Function(_ErrorCollectionState value)? error,
    TResult Function(LoadedSuccessCollection value)? loadedCollectionSuccess,
    TResult Function(LoadedCollectionItemState value)? loadedCollectionItems,
    required TResult orElse(),
  }) {
    if (loadedCollectionItems != null) {
      return loadedCollectionItems(this);
    }
    return orElse();
  }
}

abstract class LoadedCollectionItemState extends CollectionState {
  factory LoadedCollectionItemState(
          {required final List<CatalogItemModel> dataCollectionlList}) =
      _$LoadedCollectionItemState;
  LoadedCollectionItemState._() : super._();

  List<CatalogItemModel> get dataCollectionlList;
  @JsonKey(ignore: true)
  _$$LoadedCollectionItemStateCopyWith<_$LoadedCollectionItemState>
      get copyWith => throw _privateConstructorUsedError;
}
