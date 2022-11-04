import 'dart:async';

import 'package:cupcake/src/data/events/home/page_search.event.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:cupcake/src/services/product.service.dart';

class ProductTransformer {
  final ProductService _productService;

  ProductTransformer(): _productService = ProductService();

  StreamTransformer<PageSearchEvent, Future<List<ProductModel>>> get() {
    return StreamTransformer<PageSearchEvent,
        Future<List<ProductModel>>>.fromHandlers(
      handleData: (data, publisher) {
        final result = _productService.fetchAllProducts(data.page, data.search);
        publisher.add(result);
      },
    );
  }
}
