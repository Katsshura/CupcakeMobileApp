import 'package:cupcake/src/data/blocs/order/order_details.bolc.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/services/order.service.dart';
import 'package:flutter/material.dart';

class OrderDetailsProvider extends InheritedWidget {
  static final OrderService _orderService = OrderService();

  final OrderDetailsBloc _orderDetailsBloc;

  OrderDetailsProvider({super.key, required super.child})
      : _orderDetailsBloc = OrderDetailsBloc();

  @override
  bool updateShouldNotify(_) => true;

  static OrderDetailsProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OrderDetailsProvider>()!;

  static OrderDetailsBloc ofOrderDetails(BuildContext context) =>
      _ofProvider(context)._orderDetailsBloc;

  static void fetchOrder(BuildContext context, int orderId) {
    final tokenEvent = UserProvider.ofUser(context).lastEmittedValue!;
    final result = _orderService.getOrder(orderId, tokenEvent);
    ofOrderDetails(context).publish(result);
  }
}
