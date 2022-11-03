import 'package:cupcake/src/data/blocs/home/highlight.bloc.dart';
import 'package:cupcake/src/services/product.service.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends InheritedWidget {
  static final ProductService _productService = ProductService();

  final HighlightBloc _highlightBloc;

  HomeScreenProvider({super.key, required super.child})
      : _highlightBloc = HighlightBloc();

  @override
  bool updateShouldNotify(_) => true;

  static HomeScreenProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeScreenProvider>()!;

  static HighlightBloc ofHighlight(BuildContext context) =>
      _ofProvider(context)._highlightBloc;

  static void fetchHighlight(BuildContext context) {
    final result = _productService.fetchHighlightProduct();
    ofHighlight(context).publish(result);
  }
}
