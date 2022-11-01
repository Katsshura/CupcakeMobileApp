import 'package:cupcake/src/builders/form.builder.dart';
import 'package:cupcake/src/builders/registration_form.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/address_registration_screen.provider.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:flutter/material.dart';

class AddressRegistrationScreen extends StatelessWidget
    with FormBuilder, RegistrationFormBuilder {
  final UserRegistrationModel registrationModel;

  const AddressRegistrationScreen({super.key, required this.registrationModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
          context, TextConstants.addressRegistrationScreenTitle),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
            ),
            Center(
              child: buildLogo(context),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 45.0, top: 40.0, bottom: 10.0),
              child: Text(
                TextConstants.addressRegistrationScreenSubtitle,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    buildCepTextField(
                        AddressRegistrationScreenProvider.ofCep(context)),
                    Container(
                      height: 25,
                    ),
                    buildAddressTextField(
                        AddressRegistrationScreenProvider.ofAddress(context)),
                    Container(
                      height: 25,
                    ),
                    buildPropertyNumberTextField(
                        AddressRegistrationScreenProvider.ofPropertyNumber(
                            context)),
                    Container(
                      height: 25,
                    ),
                    buildComplementTextField(
                        AddressRegistrationScreenProvider.ofComplement(
                            context)),
                    Container(
                      height: 40.0,
                    ),
                    buildFinishButton(
                        context,
                        AddressRegistrationScreenProvider.ofAddressModel(
                            context),
                        () => AddressRegistrationScreenProvider.submitForm(
                            context, 'redirectPath', registrationModel))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
