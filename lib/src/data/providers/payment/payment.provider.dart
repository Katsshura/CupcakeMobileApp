import 'package:cupcake/src/data/blocs/payment/payment.bloc.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/models/payment/payment.model.dart';
import 'package:cupcake/src/services/payment.service.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends InheritedWidget {
  static final PaymentService _paymentService = PaymentService();

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
    final tokenClaims = JwtUtils.getJwtClaims(tokenModel.token!);
    final userId = tokenClaims!['id'] as int;
    return _paymentService.fetchPaymentMethods(userId, tokenModel);
  }
}
