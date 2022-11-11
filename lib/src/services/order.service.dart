import 'dart:convert';

import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/models/order/request/create_order.model.dart';
import 'package:cupcake/src/models/order/response/order.model.dart';
import 'package:cupcake/src/utils/utf8_json_decoder.util.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String _baseUrl = '${Env.host}/order';
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<OrderModel> createOrder(
      CreateOrderModel orderModel, UserTokenEvent jwt) async {
    setAuthorizationOnHeader(jwt);

    final result = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(orderModel.toJson()),
      headers: _headers,
    );

    if (result.statusCode != 201) return Future.error('Internal Server Error');

    return OrderModel.fromJson(UTF8JsonDecoderUtil.decode(result.bodyBytes));
  }

  Future<List<OrderModel>> listOrderForGivenUser(
      int userId, UserTokenEvent jwt) async {
    setAuthorizationOnHeader(jwt);

    final result = await http.get(
      Uri.parse('$_baseUrl/user/$userId'),
      headers: _headers,
    );

    final Iterable objects =
        UTF8JsonDecoderUtil.decode(result.bodyBytes)['content'];

    return List<OrderModel>.from(objects.map((e) => OrderModel.fromJson(e)));
  }

  Future<OrderModel> getOrder(int orderId, UserTokenEvent jwt) async {
    setAuthorizationOnHeader(jwt);

    final result =
        await http.get(Uri.parse('$_baseUrl/$orderId'), headers: _headers);

    return OrderModel.fromJson(UTF8JsonDecoderUtil.decode(result.bodyBytes));
  }

  void setAuthorizationOnHeader(UserTokenEvent tokenEvent) {
    _headers['Authorization'] = '${tokenEvent.type!} ${tokenEvent.token!}';
  }
}
