import 'package:flutter/services.dart';

class CardExpiredDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {

    final int textLength = newValue.text.length;
    final StringBuffer formattedText = StringBuffer();

    int intersectionIndex = 0;

    if (textLength >= 2) {
      formattedText.write('${newValue.text.substring(0, intersectionIndex = 2)}/' );
    }

    if (textLength >= intersectionIndex) {
      formattedText.write(newValue.text.substring(intersectionIndex));
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}