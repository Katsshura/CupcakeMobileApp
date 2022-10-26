import 'dart:async';

import '../../consts/text.const.dart';
import '../events/password_form.event.dart';

class PasswordValidatorTransformer {
  StreamTransformer<PasswordFormEvent, PasswordFormEvent> get() {
    return StreamTransformer<PasswordFormEvent, PasswordFormEvent>.fromHandlers(
        handleData: (passwordEvent, publisher) {
      if (passwordEvent.password!.isEmpty ||
          passwordEvent.password!.length < 3) {
        publisher.addError(TextConstants.passwordValidationErrorMessage);
        return;
      }

      publisher.add(passwordEvent);
    });
  }
}
