import 'package:cupcake/src/builders/form.builder.dart';
import 'package:cupcake/src/builders/registration_form.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/registration_screen.provider.dart';
import 'package:cupcake/src/widgets/custom_app_bar.widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget
    with FormBuilder, RegistrationFormBuilder {
  final TextEditingController _dateController = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar.build(context, TextConstants.registrationScreenTitle),
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
                TextConstants.registrationScreenSubtitle,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    buildNameTextField(
                        RegistrationScreenProvider.ofName(context)),
                    Container(
                      height: 25,
                    ),
                    buildEmailTextField(
                        RegistrationScreenProvider.ofEmail(context)),
                    Container(
                      height: 25,
                    ),
                    buildCpfTextField(
                        RegistrationScreenProvider.ofCpf(context)),
                    Container(
                      height: 25,
                    ),
                    buildBirthdayTextField(
                        RegistrationScreenProvider.ofBirthday(context),
                        _dateController),
                    Container(
                      height: 25,
                    ),
                    buildPasswordTextField(
                        RegistrationScreenProvider.ofPassword(context)),
                    Container(
                      height: 40.0,
                    ),
                    buildNextButton(
                        context,
                        RegistrationScreenProvider.ofUserRegistrationModel(
                            context))
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
