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
                ? () => print('Error')
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
}
