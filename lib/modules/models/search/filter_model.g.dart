// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FilterModel _$$_FilterModelFromJson(Map<String, dynamic> json) =>
    _$_FilterModel(
      forSale: json['forSale'] as bool? ?? false,
      sortBy: json['sortBy'] as int? ?? 0,
      collection: json['collection'] as String? ?? null,
      productType: (json['productType'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          null,
      type: json['type'] as String? ?? null,
      theme:
          (json['theme'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              null,
      conditions: (json['conditions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          null,
      releaseYears: (json['releaseYears'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          null,
      priceRanges: (json['priceRanges'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          null,
      rarityScore: json['rarityScore'] as String? ?? null,
    );

Map<String, dynamic> _$$_FilterModelToJson(_$_FilterModel instance) =>
    <String, dynamic>{
      'forSale': instance.forSale,
      'sortBy': instance.sortBy,
      'collection': instance.collection,
      'productType': instance.productType,
      'type': instance.type,
      'theme': instance.theme,
      'conditions': instance.conditions,
      'releaseYears': instance.releaseYears,
      'priceRanges': instance.priceRanges,
      'rarityScore': instance.rarityScore,
    };
