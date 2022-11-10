import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:flutter/material.dart';

class NewPaymentWidget extends StatelessWidget {
  const NewPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: 96,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(
              context,
              RoutesPath.paymentRegister,
              arguments: RoutesPath.payment,
            ),
        child: SizedBox(
          width: 96,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(
                  Icons.add,
                  size: 36,
                ),
              ),
              Container(height: 8,),
              Text(TextConstants.paymentNewCardLabel, style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium, textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }

}