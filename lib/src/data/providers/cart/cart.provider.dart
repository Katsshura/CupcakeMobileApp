import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/data/blocs/cart/cart.bloc.dart';
import 'package:cupcake/src/data/blocs/cart/cart_total.bloc.dart';
import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/enums/cart_actions.enum.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:flutter/material.dart';

class CartProvider extends InheritedWidget {
  final CartBloc _cartBloc;
  final CartTotalBloc _cartTotalBloc;

  CartProvider({super.key, required super.child})
      : _cartBloc = CartBloc(),
        _cartTotalBloc = CartTotalBloc();

  @override
  bool updateShouldNotify(_) => true;

  static CartProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>()!;

  static CartBloc ofCart(BuildContext context) =>
      _ofProvider(context)._cartBloc;

  static CartTotalBloc ofTotal(BuildContext context) =>
      _ofProvider(context)._cartTotalBloc;

  static void redirectToPaymentOrLogin(BuildContext context) {
    final token = UserProvider.ofUser(context).lastEmittedValue?.token;

    if (!JwtUtils.isValid(token)) {
      Navigator.pushNamed(context, RoutesPath.login,
          arguments: RoutesPath.payment);
      return;
    }

    Navigator.pushNamed(context, RoutesPath.payment);
  }

  static void clearCart(BuildContext context) {
    ofCart(context).publish(CartEvent(CartAction.clear, -1));
  }
}
