import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:flutter/material.dart';

import '../consts/text.const.dart';
import '../data/blocs/bloc.dart';
import '../data/events/password_form.event.dart';

class FormBuilder {
  Widget buildEmailTextField(Bloc<String, String> bloc) {
    return StreamBuilder<String>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(
                        width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.2))),
                labelText: TextConstants.emailLabelText,
                hintText: TextConstants.emailHintText,
                errorText: snapshot.error?.toString(),
                border: const OutlineInputBorder()),
            onChanged: bloc.publish,
          );
        });
  }

  Widget buildPasswordTextField(
      Bloc<PasswordFormEvent, PasswordFormEvent> bloc) {
    return StreamBuilder<PasswordFormEvent>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final snapshotData = snapshot.data;
          return TextField(
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(
                      width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.2))),
              labelText: TextConstants.passwordLabelText,
              hintText: TextConstants.passwordHintText,
              errorText: snapshot.error?.toString(),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(snapshotData?.hidden == true
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () =>
                    bloc.publish(_togglePasswordVisibility(snapshot)),
              ),
            ),
            obscureText: snapshotData?.hidden ?? true,
            onChanged: (value) =>
                bloc.publish(PasswordFormEvent(value, snapshotData?.hidden)),
          );
        });
  }

  Widget buildSubmitButton(Stream<bool> stream, Function onPressed) {
    return StreamBuilder<bool>(
        stream: stream,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: !snapshot.hasData
                ? () => ToastBuilder.showErrorToast(
                context, TextConstants.formSubmitErrorMessage)
                : () => onPressed.call(),
            style: buildButtonStyle(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(TextConstants.submitButtonText),
              ],
            ),
          );
        });
  }

  Widget buildRegisterButton(Function onPressed, BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed.call(),
      style: buildButtonStyle(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(TextConstants.registerButtonText),
        ],
      ),
    );
  }

  Widget buildLoginWithAppleButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _underDevelopmentDialog(context),
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromRGBO(255, 255, 255, 0.93))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.apple, color: Colors.black),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextConstants.signInWithAppleButtonText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget buildLoginWithGoogleButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _underDevelopmentDialog(context),
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromRGBO(255, 255, 255, 0.93))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 24.0,
                height: 24.0,
                child: Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    fit: BoxFit.cover)),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextConstants.signInWithGoogleButtonText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget buildLogo(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Image.asset("lib/resources/images/coffee_logo.png"),
          ),
        ],
      ),
    );
  }

  Widget buildLogoWithText(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Image.asset("lib/resources/images/coffee_logo.png"),
          ),
          Container(
            height: 17,
          ),
          RichText(
              text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
                fontFamily: 'Montserrat'),
            children: <TextSpan>[
              TextSpan(
                  text: 'C',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              const TextSpan(text: 'offee '),
              TextSpan(
                  text: 'D',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              const TextSpan(text: 'elivery'),
            ],
          )),
          Container(
            height: 20,
          ),
          Text(
            TextConstants.logoSubtitleText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  ButtonStyle buildButtonStyle(BuildContext context) {
    return ButtonStyle(
        elevation: MaterialStateProperty.all(5.0),
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),
        textStyle: MaterialStateProperty.resolveWith(
            (states) => Theme.of(context).textTheme.button));
  }

  PasswordFormEvent _togglePasswordVisibility(
      AsyncSnapshot<PasswordFormEvent> snapshot) {
    if (!snapshot.hasData) return PasswordFormEvent('', true);
    final toggled = !snapshot.data!.hidden;
    return PasswordFormEvent(snapshot.data!.password, toggled);
  }

  void _underDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature em desenvolvimento!'),
        content: const Text(
            'Essa funcionalidade é apenas visual, será desenvolvida posteriormente.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Entendido'))
        ],
      ),
    );
  }
}
