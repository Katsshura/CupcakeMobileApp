import 'dart:convert';
import 'dart:typed_data';

class UTF8JsonDecoderUtil {
  static dynamic decode(Uint8List body) {
    return json.decode(utf8.decode(body));
  }
}