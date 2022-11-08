import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/events/cart/cart.event.dart';
import 'package:cupcake/src/data/transformers/cart.transformer.dart';
import 'package:cupcake/src/models/cart/cart.model.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc implements Bloc<CartEvent, Map<int, CartModel>> {
  final PublishSubject<CartEvent> _cartInputController;
  final BehaviorSubject<Map<int, CartModel>> _cartOutputController;
  final CartTransformer _transformer;

  CartBloc()
      : _cartInputController = PublishSubject<CartEvent>(),
        _cartOutputController = BehaviorSubject<Map<int, CartModel>>(),
        _transformer = CartTransformer() {
    _cartInputController.stream
        .transform(_transformer.get())
        .pipe(_cartOutputController);
  }

  @override
  Map<int, CartModel> get lastEmittedValue => _cartOutputController.value;

  @override
  Stream<Map<int, CartModel>> get stream => _cartOutputController.stream;

  @override
  void publish(CartEvent value) => _cartInputController.sink.add(value);

  @override
  void dispose() {
    _cartInputController.close();
    _cartOutputController.close();
  }
}
