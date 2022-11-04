import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/events/home/page_search.event.dart';
import 'package:cupcake/src/data/transformers/product.transformer.dart';
import 'package:cupcake/src/models/product/product.model.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc implements Bloc<PageSearchEvent, Future<List<ProductModel>>> {
  final BehaviorSubject<Future<List<ProductModel>>> _outputController;
  final PublishSubject<PageSearchEvent> _inputController;
  final ProductTransformer _transformer;

  ProductBloc()
      : _outputController = BehaviorSubject<Future<List<ProductModel>>>(),
        _inputController = PublishSubject<PageSearchEvent>(),
        _transformer = ProductTransformer() {
    _inputController.stream
        .transform(_transformer.get())
        .pipe(_outputController);
  }

  @override
  Future<List<ProductModel>> get lastEmittedValue => _outputController.value;

  @override
  Stream<Future<List<ProductModel>>> get stream => _outputController.stream;

  @override
  void publish(PageSearchEvent value) => _inputController.sink.add(value);

  @override
  void dispose() {
    _outputController.close();
    _inputController.close();
  }
}
