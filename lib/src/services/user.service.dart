import 'dart:convert';

import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:cupcake/src/models/user/user_login.model.dart';
import 'package:cupcake/src/models/user/user_token.model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = '${Env.host}/user';
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<UserTokenModel> login(UserLoginModel body) async {
    final result = await http.post(
      Uri.parse('$_baseUrl/signin'),
      body: json.encode(body.toJson()),
      headers: headers,
    );

    if (result.statusCode == 401) return Future.error('Unauthorized User!');

    return UserTokenModel.fromJson(json.decode(result.body));
  }

  Future<bool> registerUser(UserRegistrationModel body) async {
    final result = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(body.toJson()),
      headers: headers,
    );

    if (result.statusCode != 201) return Future.error('Internal Server Error!');

    return Future.value(true);
  }
}
