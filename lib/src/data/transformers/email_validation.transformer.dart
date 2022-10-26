import 'dart:async';

import '../../consts/text.const.dart';

class EmailValidationTransformer {
  static const Pattern pattern =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  StreamTransformer<String, String> get() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (email, publisher) {
        RegExp regex = RegExp(pattern.toString());

        if (email.isEmpty == true || !regex.hasMatch(email)) {
          publisher.addError(TextConstants.emailValidationErrorMessage);
          return;
        }

        publisher.add(email);
      },
    );
  }
}
