import 'dart:async';

import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/extension/string.extension.dart';

class StringDefaultValidatorTransformer {
  final int minLength;

  StringDefaultValidatorTransformer(this.minLength);

  StreamTransformer<String, String> get() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (data, publisher) {
        if (data.isEmpty == true || data.length < minLength) {
          publisher.addError(TextConstants.stringDefaultValidationErrorMessage
              .format([minLength.toString()]));
          return;
        }

        publisher.add(data);
      },
    );
  }
}
