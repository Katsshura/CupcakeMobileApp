// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderModel _$CreateOrderModelFromJson(Map<String, dynamic> json) =>
    CreateOrderModel(
      json['user_id'] as int,
      json['payment_id'] as int,
      Decimal.fromJson(json['extra_charges'] as String),
      (json['products_quantities'] as List<dynamic>)
          .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrderModelToJson(CreateOrderModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'payment_id': instance.paymentId,
      'extra_charges': decimalToDouble(instance.extraCharges),
      'products_quantities':
          instance.productQuantities.map((e) => e.toJson()).toList(),
    };
