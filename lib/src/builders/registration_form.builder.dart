import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:flutter/material.dart';

class RegistrationFormBuilder {
  Widget buildNameTextField(Bloc<String, String> bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        return TextField(
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(
                width: 1.0,
                color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
            ),
            labelText: TextConstants.nameLabelText,
            hintText: TextConstants.nameHintText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
        );
      },
    );
  }

  Widget buildCpfTextField(Bloc<String, String> bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        return TextField(
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(
                width: 1.0,
                color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
            ),
            labelText: TextConstants.cpfLabelText,
            hintText: TextConstants.cpfHintText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
        );
      },
    );
  }

  Widget buildBirthdayTextField(Bloc<String, String> bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        return TextField(
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(
                width: 1.0,
                color: Color.fromRGBO(0, 0, 0, 0.2),
              ),
            ),
            labelText: TextConstants.birthdayLabelText,
            hintText: TextConstants.birthdayHintText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
        );
      },
    );
  }

  Widget buildNextButton(Function onPressed, BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed.call(),
      style: buildButtonStyle(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(TextConstants.nextButtonLabel),
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
}