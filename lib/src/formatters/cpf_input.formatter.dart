import 'package:flutter/services.dart';

class CPFInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {

    final int textLength = newValue.text.length;
    final StringBuffer formattedText = StringBuffer();

    int intersectionIndex = 0;

    if (textLength >= 3) {
      formattedText.write('${newValue.text.substring(0, intersectionIndex = 3)}.' );
    }
    if (textLength >= 6) {
      formattedText.write('${newValue.text.substring(3, intersectionIndex = 6)}.');
    }
    if (textLength >= 9) {
      formattedText.write('${newValue.text.substring(6, intersectionIndex = 9)}-' );
    }

    // if (textLength == 11) {
    //   formattedText.write(newValue.text.substring(9));
    // }
    if (textLength >= intersectionIndex) {
      formattedText.write(newValue.text.substring(intersectionIndex));
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}