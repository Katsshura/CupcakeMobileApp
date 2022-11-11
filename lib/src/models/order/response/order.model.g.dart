// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['order_id'] as int,
      doubleToDecimal(json['order_total'] as double),
      doubleToDecimal(json['delivery_tax'] as double),
      (json['order_items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['order_status'] as List<dynamic>)
          .map((e) => OrderStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'order_total': decimalToDouble(instance.orderTotal),
      'delivery_tax': decimalToDouble(instance.deliveryTax),
      'order_items': instance.orderItems.map((e) => e.toJson()).toList(),
      'order_status': instance.orderStatus.map((e) => e.toJson()).toList(),
    };
