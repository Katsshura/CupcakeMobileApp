import 'package:cupcake/src/consts/text.const.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CartTotals extends StatelessWidget {
  final Decimal totalValue;
  final Function onPressed;

  const CartTotals(
      {super.key, required this.totalValue, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(TextConstants.cartTotalLabel,
                    style: Theme.of(context).textTheme.headline5),
                Text(
                  'R\$ $totalValue',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Text(
              TextConstants.cartWarningLabel,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton(
              onPressed: () => onPressed.call(),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5.0),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor),
                  textStyle: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).textTheme.button)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(TextConstants.goToPaymentButton),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
