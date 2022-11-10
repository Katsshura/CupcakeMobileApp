import 'package:cupcake/src/models/order/request/order_product.model.dart';
import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_order.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateOrderModel {
  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'payment_id')
  int paymentId;

  @JsonKey(name: 'extra_charges', toJson: decimalToDouble)
  Decimal extraCharges;

  @JsonKey(name: 'products_quantities')
  List<OrderProductModel> productQuantities;

  CreateOrderModel(
      this.userId, this.paymentId, this.extraCharges, this.productQuantities);

  Map<String, dynamic> toJson() => _$CreateOrderModelToJson(this);

}

double decimalToDouble(Decimal value) => value.toDouble();