import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/models/product/product.model.dart';

class CartEvent {
  final CartAction action;
  final int productId;
  final ProductModel? product;
  final int? argument;

  CartEvent(this.action, this.productId, [this.product, this.argument]);
}