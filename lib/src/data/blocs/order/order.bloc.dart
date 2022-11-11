import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/models/order/response/order.model.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc
    implements Bloc<Future<List<OrderModel>>, Future<List<OrderModel>>> {

  final BehaviorSubject<Future<List<OrderModel>>> _controller;

  OrderBloc(): _controller = BehaviorSubject<Future<List<OrderModel>>>();

  @override
  Future<List<OrderModel>> get lastEmittedValue => _controller.value;

  @override
  Stream<Future<List<OrderModel>>> get stream => _controller.stream;

  @override
  void publish(Future<List<OrderModel>> value) => _controller.sink.add(value);

  @override
  void dispose() {
    _controller.close();
  }
}
