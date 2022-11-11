import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/models/order/response/order.model.dart';
import 'package:rxdart/subjects.dart';

class OrderDetailsBloc implements Bloc<Future<OrderModel>, Future<OrderModel>> {
  final BehaviorSubject<Future<OrderModel>> _controller;

  OrderDetailsBloc(): _controller = BehaviorSubject<Future<OrderModel>>();

  @override
  Future<OrderModel> get lastEmittedValue => _controller.value;

  @override
  Stream<Future<OrderModel>> get stream => _controller.stream;

  @override
  void publish(Future<OrderModel> value) => _controller.sink.add(value);

  @override
  void dispose() {
    _controller.close();
  }
}