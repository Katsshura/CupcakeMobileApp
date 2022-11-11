import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/payment/payment.bloc.dart';
import 'package:cupcake/src/data/providers/cart/cart.provider.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/models/order/request/create_order.model.dart';
import 'package:cupcake/src/models/order/request/order_product.model.dart';
import 'package:cupcake/src/models/payment/payment.model.dart';
import 'package:cupcake/src/services/order.service.dart';
import 'package:cupcake/src/services/payment.service.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends InheritedWidget {
  static final PaymentService _paymentService = PaymentService();
  static final OrderService _orderService = OrderService();

  final PaymentBloc _paymentBloc;

  PaymentProvider({super.key, required super.child})
      : _paymentBloc = PaymentBloc();

  @override
  bool updateShouldNotify(_) => true;

  static PaymentProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PaymentProvider>()!;

  static PaymentBloc ofPayment(BuildContext context) =>
      _ofProvider(context)._paymentBloc;

  static Future<List<PaymentModel>> getPaymentMethods(BuildContext context) {
    final tokenModel = UserProvider.ofUser(context).lastEmittedValue!;
    final userId = JwtUtils.getUserId(tokenModel);
    return _paymentService.fetchPaymentMethods(userId, tokenModel);
  }

  static void createOrder(BuildContext context) {
    final tokenEvent = UserProvider.ofUser(context).lastEmittedValue!;
    final userId = JwtUtils.getUserId(tokenEvent);
    final cartItems = CartProvider.ofCart(context).lastEmittedValue;
    final paymentId = ofPayment(context).lastEmittedValue;
    final extraCharges = Decimal.parse('6.99');

    final order = CreateOrderModel(
        userId,
        paymentId,
        extraCharges,
        cartItems.entries
            .map((entry) => OrderProductModel(entry.key, entry.value.quantity))
            .toList());

    _orderService.createOrder(order, tokenEvent).then((value) {
      ToastBuilder.showSuccessToast(
          context, TextConstants.orderCreatedWithSuccess);
      return Navigator.pushNamedAndRemoveUntil(
          context, RoutesPath.orderDetails, (route) => route.isFirst,
          arguments: value.orderId);
    }).catchError((error) {
      ToastBuilder.showErrorToast(context, error.toString());
    });
    ;
  }
}
