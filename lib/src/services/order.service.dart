import 'dart:convert';

import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/models/order/request/create_order.model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String _baseUrl = '${Env.host}/order';
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<bool> createOrder(CreateOrderModel orderModel, UserTokenEvent jwt) async {
    setAuthorizationOnHeader(jwt);

    final result = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(orderModel.toJson()),
      headers: _headers,
    );

    if (result.statusCode != 201) return Future.error('Internal Server Error');

    return Future.value(true);
  }

  void setAuthorizationOnHeader(UserTokenEvent tokenEvent) {
    _headers['Authorization'] = '${tokenEvent.type!} ${tokenEvent.token!}';
  }
}