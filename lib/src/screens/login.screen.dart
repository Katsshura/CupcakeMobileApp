import 'package:cupcake/src/builders/form.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/providers/login_screen.provider.dart';
import 'package:cupcake/src/widgets/text_divider.widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget with FormBuilder {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.3,
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(height: 50,),
              buildLogoWithText(context),
              Container(height: 30,),
              buildEmailTextField(LoginScreenProvider.ofEmail(context)),
              Container(height: 9.0,),
              buildPasswordTextField(LoginScreenProvider.ofPassword(context)),
              Container(height: 30.0,),
              buildSubmitButton(LoginScreenProvider.isSubmitValid(context),
                  () => LoginScreenProvider.submitForm(context)),
              buildRegisterButton(() => Navigator.pushNamed(context, 'routeName'), context),
              Container(height: 25,),
              TextDivider(text: TextConstants.loginScreenDividerText),
              buildLoginWithGoogleButton(context),
              buildLoginWithAppleButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
