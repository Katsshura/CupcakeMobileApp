import 'package:cupcake/src/models/product/product.model.dart';

class CartModel {
  final ProductModel product;
  int _quantity = 0;

  CartModel(this.product, int quantity) {
    _quantity = quantity;
  }

  int get quantity => _quantity;

  void decreaseQuantity([int? value]) {
    _quantity -= value ?? 1;
  }

  void increaseQuantity([int? value]) {
    _quantity += value ?? 1;
  }
}