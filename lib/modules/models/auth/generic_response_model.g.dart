// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenericResponseModel _$$_GenericResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_GenericResponseModel(
      errorCode: json['errorCode'] as String? ?? defaultString,
      errorMessage: json['errorMessage'] as String? ?? defaultString,
      token: json['token'] as String? ?? defaultString,
      accountId: json['accountId'] as String? ?? defaultString,
      hasImportableData: json['hasImportableData'] as bool? ?? false,
    );

Map<String, dynamic> _$$_GenericResponseModelToJson(
        _$_GenericResponseModel instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
      'token': instance.token,
      'accountId': instance.accountId,
      'hasImportableData': instance.hasImportableData,
    };
