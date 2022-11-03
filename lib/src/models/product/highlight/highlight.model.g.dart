// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighlightModel _$HighlightModelFromJson(Map<String, dynamic> json) =>
    HighlightModel(
      json['id'] as int,
      json['enabled'] as bool,
      json['title'] as String,
      json['subtitle'] as String,
      ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HighlightModelToJson(HighlightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'product': instance.product.toJson(),
    };
