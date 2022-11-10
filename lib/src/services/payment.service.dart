import 'dart:convert';

import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/models/payment/payment.model.dart';
import 'package:cupcake/src/extension/string.extension.dart';
import 'package:cupcake/src/utils/utf8_json_decoder.util.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  final String _baseUrl = '${Env.host}/user/%s/payment/card';
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<PaymentModel>> fetchPaymentMethods(
      int userId, UserTokenEvent tokenEvent,) async {

    setAuthorizationOnHeader(tokenEvent);

    final apiResult = await http.get(
      Uri.parse(_baseUrl.format([userId])), headers: _headers,);
    final Iterable objects = UTF8JsonDecoderUtil.decode(apiResult.bodyBytes);

    return List<PaymentModel>.from(
        objects.map((e) => PaymentModel.fromJson(e)));
  }

  Future<bool> createPayment(int userId,
      PaymentModel model,
      UserTokenEvent tokenEvent,) async {

    setAuthorizationOnHeader(tokenEvent);

    final result = await http.post(
      Uri.parse(_baseUrl.format([userId])),
      body: json.encode(model.toJson()),
      headers: _headers,
    );

    if (result.statusCode != 201) return Future.error('Internal Server Error');

    return Future.value(true);
  }

  void setAuthorizationOnHeader(UserTokenEvent tokenEvent) {
    _headers['Authorization'] = '${tokenEvent.type!} ${tokenEvent.token!}';
  }
}
