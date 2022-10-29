import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/formatters/cpf_input.formatter.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(11),
            CPFInputFormatter(),
          ],
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
    final controller = TextEditingController();
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        return TextField(
          style: Theme.of(context).textTheme.labelMedium,
          controller: controller,
          keyboardType: TextInputType.datetime,
          readOnly: true,
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
          onTap: () async {
             final result = await _pickDateDialog(context) ?? '';
             controller.text = result;
             bloc.publish(result);
          },
        );
      },
    );
  }

  Widget buildNextButton(
      BuildContext context, Stream<UserRegistrationModel> stream) {
    return StreamBuilder<UserRegistrationModel>(
        stream: stream,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: !snapshot.hasData
                ? () => ToastBuilder.showErrorToast(
                    context, TextConstants.proceedToAddressRegistrationError)
                : () => Navigator.pushNamed(
                    context, RoutesPath.registrationAddress,
                    arguments: snapshot.data!),
            style: buildButtonStyle(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(TextConstants.nextButtonLabel),
              ],
            ),
          );
        });
  }

  ButtonStyle buildButtonStyle(BuildContext context) {
    return ButtonStyle(
        elevation: MaterialStateProperty.all(5.0),
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => Theme.of(context).primaryColor),
        textStyle: MaterialStateProperty.resolveWith(
            (states) => Theme.of(context).textTheme.button));
  }

  Future<String?> _pickDateDialog(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      return formattedDate;
    }

    return null;
  }
}
