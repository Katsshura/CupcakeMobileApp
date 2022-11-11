import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/form/cpf.bloc.dart';
import 'package:cupcake/src/data/blocs/form/user_name.bloc.dart';
import 'package:cupcake/src/data/blocs/payment/registration/card_cvv.bloc.dart';
import 'package:cupcake/src/data/blocs/payment/registration/card_expire_date.bloc.dart';
import 'package:cupcake/src/data/blocs/payment/registration/card_name.bloc.dart';
import 'package:cupcake/src/data/blocs/payment/registration/card_number.bloc.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/models/payment/payment.model.dart';
import 'package:cupcake/src/services/payment.service.dart';
import 'package:cupcake/src/utils/jwt.util.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart' as rx;

class PaymentRegistrationProvider extends InheritedWidget {
  static final PaymentService _paymentService = PaymentService();

  final CardNameBloc _cardNameBloc;
  final CardNumberBloc _cardNumberBloc;
  final CardCVVBloc _cardCVVBloc;
  final CardExpireDateBloc _cardExpireDateBloc;
  final CPFBloc _cpfBloc;
  final UserNameBloc _userNameBloc;

  PaymentRegistrationProvider({super.key, required super.child})
      : _cardNameBloc = CardNameBloc(),
        _cardNumberBloc = CardNumberBloc(),
        _cardCVVBloc = CardCVVBloc(),
        _cardExpireDateBloc = CardExpireDateBloc(),
        _cpfBloc = CPFBloc(),
        _userNameBloc = UserNameBloc();

  @override
  bool updateShouldNotify(_) => true;

  static PaymentRegistrationProvider _ofProvider(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<PaymentRegistrationProvider>()!;

  static CPFBloc ofCpf(BuildContext context) => _ofProvider(context)._cpfBloc;

  static UserNameBloc ofName(BuildContext context) =>
      _ofProvider(context)._userNameBloc;

  static CardNameBloc ofCardName(BuildContext context) =>
      _ofProvider(context)._cardNameBloc;

  static CardNumberBloc ofCardNumber(BuildContext context) =>
      _ofProvider(context)._cardNumberBloc;

  static CardCVVBloc ofCardCVV(BuildContext context) =>
      _ofProvider(context)._cardCVVBloc;

  static CardExpireDateBloc ofCardExpireDate(BuildContext context) =>
      _ofProvider(context)._cardExpireDateBloc;

  static Stream<bool> isSubmitValid(BuildContext context) {
    final userNameStream = ofName(context).stream;
    final cpfStream = ofCpf(context).stream;
    final cardNameStream = ofCardName(context).stream;
    final cardNumberStream = ofCardNumber(context).stream;
    final cardCvvStream = ofCardCVV(context).stream;
    final cardExpireDateStream = ofCardExpireDate(context).stream;

    return rx.CombineLatestStream.combine6(
        userNameStream,
        cpfStream,
        cardNameStream,
        cardNumberStream,
        cardCvvStream,
        cardExpireDateStream,
        (a, b, c, d, e, f) => true);
  }

  static void submitForm(BuildContext context, String redirectPath) {
    final tokenEvent = UserProvider.ofUser(context).lastEmittedValue!;
    final userId = JwtUtils.getUserId(tokenEvent);
    final cardName = ofCardName(context).lastEmittedValue;
    final cardNumber =
        ofCardNumber(context).lastEmittedValue.replaceAll(' ', '');
    final cardCvv = ofCardCVV(context).lastEmittedValue;
    final cardExpireDate = ofCardExpireDate(context).lastEmittedValue;
    final cardFlag = _getCardFlag(cardNumber);

    final body = PaymentModel(
        cardNumber, cardExpireDate, int.parse(cardCvv), cardName, cardFlag);

    _paymentService.createPayment(userId, body, tokenEvent).then((value) {
      ToastBuilder.showSuccessToast(
          context, TextConstants.paymentCreatedWithSuccess);
      return Navigator.pushNamed(context, redirectPath);
    }).catchError((error) {
      ToastBuilder.showErrorToast(context, error.toString());
    });
  }

  static String _getCardFlag(String cardNumber) {
    if (cardNumber[0] == '5') return 'MASTERCARD';
    if (cardNumber[0] == '4') return 'VISA';
    return 'ELO';
  }
}
