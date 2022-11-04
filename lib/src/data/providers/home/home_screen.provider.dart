import 'package:cupcake/src/data/blocs/home/highlight.bloc.dart';
import 'package:cupcake/src/data/blocs/home/product.bloc.dart';
import 'package:cupcake/src/data/events/home/page_search.event.dart';
import 'package:cupcake/src/services/product.service.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends InheritedWidget {
  static final ProductService _productService = ProductService();

  final HighlightBloc _highlightBloc;
  final ProductBloc _productBloc;

  HomeScreenProvider({super.key, required super.child})
      : _highlightBloc = HighlightBloc(),
        _productBloc = ProductBloc();

  @override
  bool updateShouldNotify(_) => true;

  static HomeScreenProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeScreenProvider>()!;

  static HighlightBloc ofHighlight(BuildContext context) =>
      _ofProvider(context)._highlightBloc;

  static ProductBloc ofProduct(BuildContext context) =>
      _ofProvider(context)._productBloc;

  static void fetchHighlight(BuildContext context) {
    final result = _productService.fetchHighlightProduct();
    ofHighlight(context).publish(result);
  }

  static void fetchProducts(BuildContext context, int page, String search) {
    ofProduct(context).publish(PageSearchEvent(page, search));
  }
}
