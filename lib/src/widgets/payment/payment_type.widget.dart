import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/models/payment/payment.model.dart';
import 'package:flutter/material.dart';

class PaymentTypeWidget extends StatelessWidget {
  final PaymentModel paymentModel;
  final Function onPressed;
  final int selected;

  const PaymentTypeWidget(
      {super.key,
      required this.paymentModel,
      required this.onPressed,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    final color =
        selected == paymentModel.id ? Colors.blueAccent : Colors.transparent;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: SizedBox(
        height: 96,
        width: 96,
        child: InkWell(
          onTap: () => onPressed.call(),
          child: SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: getCardImage(),
                  ),
                ),
                Container(
                  height: 8,
                ),
                Text(
                  '•••• ${paymentModel.cardNumber.substring(paymentModel.cardNumber.length - 4)}',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 8,
                ),
                Text(
                  paymentModel.customName,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCardImage() {
    switch (paymentModel.cardFlag) {
      case 'ELO':
        return Image.asset("lib/resources/images/elo.png");
      case 'MASTERCARD':
        return Image.asset("lib/resources/images/mastercard.png");
      case 'VISA':
        return Image.asset("lib/resources/images/visa.png");
      default:
        return const Icon(Icons.credit_card_rounded);
    }
  }
}
