// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as int,
      json['available_stock'] as int,
      json['name'] as String,
      json['description'] as String,
      json['image_url'] as String,
      doubleToDecimal(json['price'] as double),
      doubleToDecimal(json['popularity'] as double),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'available_stock': instance.availableStock,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'price': decimalToDouble(instance.price),
      'popularity': decimalToDouble(instance.popularity),
    };
