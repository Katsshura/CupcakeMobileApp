// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusModel _$OrderStatusModelFromJson(Map<String, dynamic> json) =>
    OrderStatusModel(
      json['status'] as String,
      json['active'] as bool,
    );

Map<String, dynamic> _$OrderStatusModelToJson(OrderStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'active': instance.active,
    };
