// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForgotPasswordCodeModel _$ForgotPasswordCodeModelFromJson(
    Map<String, dynamic> json) {
  return _ForgotPasswordCodeModel.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordCodeModel {
  String get statusCode => throw _privateConstructorUsedError;
  String get statusMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotPasswordCodeModelCopyWith<ForgotPasswordCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordCodeModelCopyWith<$Res> {
  factory $ForgotPasswordCodeModelCopyWith(ForgotPasswordCodeModel value,
          $Res Function(ForgotPasswordCodeModel) then) =
      _$ForgotPasswordCodeModelCopyWithImpl<$Res, ForgotPasswordCodeModel>;
  @useResult
  $Res call({String statusCode, String statusMessage});
}

/// @nodoc
class _$ForgotPasswordCodeModelCopyWithImpl<$Res,
        $Val extends ForgotPasswordCodeModel>
    implements $ForgotPasswordCodeModelCopyWith<$Res> {
  _$ForgotPasswordCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? statusMessage = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as String,
      statusMessage: null == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgotPasswordCodeModelCopyWith<$Res>
    implements $ForgotPasswordCodeModelCopyWith<$Res> {
  factory _$$_ForgotPasswordCodeModelCopyWith(_$_ForgotPasswordCodeModel value,
          $Res Function(_$_ForgotPasswordCodeModel) then) =
      __$$_ForgotPasswordCodeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String statusCode, String statusMessage});
}

/// @nodoc
class __$$_ForgotPasswordCodeModelCopyWithImpl<$Res>
    extends _$ForgotPasswordCodeModelCopyWithImpl<$Res,
        _$_ForgotPasswordCodeModel>
    implements _$$_ForgotPasswordCodeModelCopyWith<$Res> {
  __$$_ForgotPasswordCodeModelCopyWithImpl(_$_ForgotPasswordCodeModel _value,
      $Res Function(_$_ForgotPasswordCodeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? statusMessage = null,
  }) {
    return _then(_$_ForgotPasswordCodeModel(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as String,
      statusMessage: null == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ForgotPasswordCodeModel implements _ForgotPasswordCodeModel {
  const _$_ForgotPasswordCodeModel(
      {required this.statusCode, required this.statusMessage});

  factory _$_ForgotPasswordCodeModel.fromJson(Map<String, dynamic> json) =>
      _$$_ForgotPasswordCodeModelFromJson(json);

  @override
  final String statusCode;
  @override
  final String statusMessage;

  @override
  String toString() {
    return 'ForgotPasswordCodeModel(statusCode: $statusCode, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgotPasswordCodeModel &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, statusMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgotPasswordCodeModelCopyWith<_$_ForgotPasswordCodeModel>
      get copyWith =>
          __$$_ForgotPasswordCodeModelCopyWithImpl<_$_ForgotPasswordCodeModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForgotPasswordCodeModelToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordCodeModel implements ForgotPasswordCodeModel {
  const factory _ForgotPasswordCodeModel(
      {required final String statusCode,
      required final String statusMessage}) = _$_ForgotPasswordCodeModel;

  factory _ForgotPasswordCodeModel.fromJson(Map<String, dynamic> json) =
      _$_ForgotPasswordCodeModel.fromJson;

  @override
  String get statusCode;
  @override
  String get statusMessage;
  @override
  @JsonKey(ignore: true)
  _$$_ForgotPasswordCodeModelCopyWith<_$_ForgotPasswordCodeModel>
      get copyWith => throw _privateConstructorUsedError;
}
