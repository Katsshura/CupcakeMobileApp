import 'dart:convert';

import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:flutter/material.dart';

class JwtUtils {

  static Map<String, dynamic>? getJwtClaims(String token) {
    final sections = token.split('.');

    if (sections.length != 3) {
      return {};
    }

    final encodedPayload = base64Url.normalize(sections[1]);
    final payload = utf8.decode(base64Url.decode(encodedPayload));

    return json.decode(payload);
  }

  static bool isValid(String? token) {
    if (token == null) return false;

    final claims = getJwtClaims(token);

    if (claims == null) return false;

    final expiration = claims['exp'] as int;

    final date = DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
    return DateTime.now().isBefore(date);
  }

  static int getUserId(UserTokenEvent tokenEvent) {
    final tokenClaims = getJwtClaims(tokenEvent.token!);
    return tokenClaims!['id'] as int;
  }
}