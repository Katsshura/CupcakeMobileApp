import 'package:cupcake/src/data/blocs/order/order.bloc.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/services/order.service.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:flutter/material.dart';

class OrderProvider extends InheritedWidget {
  static final OrderService _orderService = OrderService();

  final OrderBloc _orderBloc;

  OrderProvider({super.key, required super.child}) : _orderBloc = OrderBloc();

  @override
  bool updateShouldNotify(_) => true;

  static OrderProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OrderProvider>()!;

  static OrderBloc ofOrder(BuildContext context) =>
      _ofProvider(context)._orderBloc;

  static void fetchUserOrders(BuildContext context) {
    final tokenEvent = UserProvider.ofUser(context).lastEmittedValue!;
    final userId = JwtUtils.getUserId(tokenEvent);
    final result = _orderService.listOrderForGivenUser(userId, tokenEvent);
    ofOrder(context).publish(result);
  }
}
