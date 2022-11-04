import 'dart:convert';

import 'package:cupcake/src/consts/env.const.dart';
import 'package:cupcake/src/models/product/highlight/highlight.model.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:cupcake/src/utils/utf8_json_decoder.util.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = '${Env.host}/product';
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<ProductModel>> fetchAllProducts(int page, String? search) async {
    final uri = Uri.parse('$_baseUrl?page=${page.toString()}&search=$search');

    final apiResult = await http.get(uri, headers: _headers);
    final Iterable objects =
        UTF8JsonDecoderUtil.decode(apiResult.bodyBytes)['content'];
    return List<ProductModel>.from(
        objects.map((productJson) => ProductModel.fromJson(productJson)));
  }

  Future<ProductModel> fetchProductById(int id) async {
    final result = await http.get(Uri.parse('$_baseUrl/$id'));
    return ProductModel.fromJson(UTF8JsonDecoderUtil.decode(result.bodyBytes));
  }

  Future<HighlightModel> fetchHighlightProduct() async {
    final result = await http.get(Uri.parse('$_baseUrl/highlight'));
    return HighlightModel.fromJson(
        UTF8JsonDecoderUtil.decode(result.bodyBytes));
  }
}
