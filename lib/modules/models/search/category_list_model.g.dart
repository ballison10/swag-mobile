// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryListModel _$$_CategoryListModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryListModel(
      categoryList: (json['categoryList'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CategoryListModelToJson(
        _$_CategoryListModel instance) =>
    <String, dynamic>{
      'categoryList': instance.categoryList,
    };
