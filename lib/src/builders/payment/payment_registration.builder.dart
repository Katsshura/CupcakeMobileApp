import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/formatters/card_expired_date.formatter.dart';
import 'package:cupcake/src/formatters/card_number.formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentRegistrationBuilder {
  Widget buildCardNumberTextField(Bloc<String, String> bloc) {
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
            labelText: TextConstants.cardNumberLabelText,
            hintText: TextConstants.cardNumberLabelText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(16),
            CardNumberFormatter(),
          ],
        );
      },
    );
  }

  Widget buildCardExpireDateTextField(Bloc<String, String> bloc) {
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
            labelText: TextConstants.cardExpireDateLabelText,
            hintText: TextConstants.cardExpireDateLabelText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(4),
            CardExpiredDateFormatter(),
          ],
        );
      },
    );
  }

  Widget buildCvvTextField(Bloc<String, String> bloc) {
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
            labelText: TextConstants.cardCvvLabelText,
            hintText: TextConstants.cardCvvLabelText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(3),
          ],
        );
      },
    );
  }

  Widget buildCardNameTextField(Bloc<String, String> bloc) {
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
            labelText: TextConstants.cardNameLabelText,
            hintText: TextConstants.cardNameLabelText,
            errorText: snapshot.error?.toString(),
            border: const OutlineInputBorder(),
          ),
          onChanged: bloc.publish,
        );
      },
    );
  }
}