import 'package:json_annotation/json_annotation.dart';

part 'order_product.model.g.dart';

@JsonSerializable()
class OrderProductModel {

  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'quantity')
  int quantity;

  OrderProductModel(this.productId, this.quantity);

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}