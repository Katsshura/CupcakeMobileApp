import 'package:cupcake/src/data/blocs/cart/cart.bloc.dart';
import 'package:flutter/material.dart';

class CartProvider extends InheritedWidget {
  final CartBloc _cartBloc;

  CartProvider({super.key, required super.child}) : _cartBloc = CartBloc();

  @override
  bool updateShouldNotify(_) => true;

  static CartProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>()!;

  static CartBloc ofCart(BuildContext context) =>
      _ofProvider(context)._cartBloc;
}
