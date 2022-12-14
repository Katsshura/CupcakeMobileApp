import 'package:cupcake/src/builders/form.builder.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/login_screen.provider.dart';
import 'package:cupcake/src/widgets/text_divider.widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget with FormBuilder {
  final String redirectPath;

  const LoginScreen({super.key, required this.redirectPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                buildLogoWithText(context),
                Container(
                  height: 30,
                ),
                buildEmailTextField(LoginScreenProvider.ofEmail(context)),
                Container(
                  height: 9.0,
                ),
                buildPasswordTextField(LoginScreenProvider.ofPassword(context)),
                Container(
                  height: 30.0,
                ),
                buildSubmitButton(LoginScreenProvider.isSubmitValid(context),
                    () => LoginScreenProvider.submitForm(context, redirectPath)),
                buildRegisterButton(
                    () => Navigator.pushNamed(context, RoutesPath.registration),
                    context),
                Container(
                  height: 25,
                ),
                const TextDivider(text: TextConstants.loginScreenDividerText),
                buildLoginWithGoogleButton(context),
                buildLoginWithAppleButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
