import 'package:cupcake/src/builders/form.builder.dart';
import 'package:cupcake/src/builders/payment/payment_registration.builder.dart';
import 'package:cupcake/src/builders/registration_form.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/payment/payment_registration.provider.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:flutter/material.dart';

class PaymentRegistrationScreen extends StatelessWidget
    with RegistrationFormBuilder, PaymentRegistrationBuilder {
  final String redirectPath;

  const PaymentRegistrationScreen({super.key, required this.redirectPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
          context, TextConstants.cardRegistrationScreenTitle),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 30,
                ),
                SizedBox(
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Image.asset("lib/resources/images/elo.png"),
                      ),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child:
                            Image.asset("lib/resources/images/mastercard.png"),
                      ),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Image.asset("lib/resources/images/visa.png"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                ),
                buildCardNumberTextField(
                  PaymentRegistrationProvider.ofCardNumber(context),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 1.3) / 2.1,
                      child: buildCardExpireDateTextField(
                        PaymentRegistrationProvider.ofCardExpireDate(context),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 1.3) / 2.1,
                      child: buildCvvTextField(
                        PaymentRegistrationProvider.ofCardCVV(context),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                buildNameTextField(PaymentRegistrationProvider.ofName(context)),
                Container(
                  height: 20,
                ),
                buildCpfTextField(PaymentRegistrationProvider.ofCpf(context)),
                Container(
                  height: 20,
                ),
                buildCardNameTextField(
                    PaymentRegistrationProvider.ofCardName(context)),
                Container(
                  height: 50,
                ),
                Text(
                  TextConstants.cardChargeWarning,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.justify,
                ),
                Container(
                  height: 50,
                ),
                buildFinishButton(
                  context,
                  PaymentRegistrationProvider.isSubmitValid(context),
                  () => PaymentRegistrationProvider.submitForm(
                      context, redirectPath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
