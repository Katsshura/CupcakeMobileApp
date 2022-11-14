import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/models/cart/cart.model.dart';
import 'package:rxdart/rxdart.dart';

class CartTransformer {
  ScanStreamTransformer<CartEvent, Map<int, CartModel>> get() {
    return ScanStreamTransformer<CartEvent, Map<int, CartModel>>(
        (accumulated, value, index) {
      return _execute(accumulated, value);
    }, {});
  }

  Map<int, CartModel> _execute(
      Map<int, CartModel> accumulated, CartEvent value) {
    switch (value.action) {
      case CartAction.increase:
        return _increaseOrAddProduct(accumulated, value);
      case CartAction.decrease:
        return _decrease(accumulated, value);
      case CartAction.delete:
        return _delete(accumulated, value);
      case CartAction.clear:
        accumulated.clear();
        return accumulated;
    }
  }

  Map<int, CartModel> _increaseOrAddProduct(
      Map<int, CartModel> accumulated, CartEvent value) {
    if (accumulated.containsKey(value.productId)) {
      accumulated[value.productId]!.increaseQuantity(value.argument);
      return accumulated;
    }

    accumulated[value.productId] =
        CartModel(value.product!, value.argument ?? 1);
    return accumulated;
  }

  Map<int, CartModel> _decrease(
      Map<int, CartModel> accumulated, CartEvent value) {
    if (!accumulated.containsKey(value.productId)){
      return accumulated;
    }
    if (accumulated[value.productId]!.quantity > 1) {
      accumulated[value.productId]!.decreaseQuantity(value.argument);
    }
    else if (accumulated[value.productId]!.quantity == 1) {
      return _delete(accumulated, value);
    }

    return accumulated;
  }

  Map<int, CartModel> _delete(
      Map<int, CartModel> accumulated, CartEvent value) {
    if (!accumulated.containsKey(value.productId)){
      return accumulated;
    }

    accumulated.remove(value.productId);
    return accumulated;
  }
}
