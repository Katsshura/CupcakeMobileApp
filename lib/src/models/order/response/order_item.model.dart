import 'package:cupcake/src/models/product/product.model.dart';
import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.model.g.dart';

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)
class OrderItemModel {
  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'total', fromJson: doubleToDecimal, toJson: decimalToDouble)
  Decimal total;

  @JsonKey(name: 'product')
  ProductModel product;

  OrderItemModel(this.quantity, this.total, this.product);

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

Decimal doubleToDecimal(double value) => Decimal.parse(value.toString());
double decimalToDouble(Decimal value) => value.toDouble();