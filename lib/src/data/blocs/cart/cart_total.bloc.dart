import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';

class CartTotalBloc implements Bloc<Decimal, Decimal> {
  final BehaviorSubject<Decimal> _controller;

  CartTotalBloc(): _controller = BehaviorSubject<Decimal>();

  @override
  Decimal get lastEmittedValue => _controller.value;

  @override
  Stream<Decimal> get stream => _controller.stream;

  @override
  void publish(Decimal value) => _controller.sink.add(value);

  @override
  void dispose() {
    _controller.close();
  }

}