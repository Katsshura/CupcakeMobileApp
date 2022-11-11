import 'package:cupcake/src/models/order/response/order_item.model.dart';
import 'package:cupcake/src/models/order/response/order_status.model.dart';
import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class OrderModel {
  @JsonKey(name: 'order_id')
  int orderId;

  @JsonKey(
      name: 'order_total', fromJson: doubleToDecimal, toJson: decimalToDouble)
  Decimal orderTotal;

  @JsonKey(
      name: 'delivery_tax', fromJson: doubleToDecimal, toJson: decimalToDouble)
  Decimal deliveryTax;

  @JsonKey(name: 'order_items')
  List<OrderItemModel> orderItems;

  @JsonKey(name: 'order_status')
  List<OrderStatusModel> orderStatus;

  OrderModel(this.orderId, this.orderTotal, this.deliveryTax, this.orderItems,
      this.orderStatus);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

Decimal doubleToDecimal(double value) => Decimal.parse(value.toString());

double decimalToDouble(Decimal value) => value.toDouble();
