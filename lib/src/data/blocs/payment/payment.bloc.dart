import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc implements Bloc<int, int> {
  final BehaviorSubject<int> _inputController;

  PaymentBloc(): _inputController = BehaviorSubject<int>();

  @override
  int get lastEmittedValue => _inputController.value;

  @override
  Stream<int> get stream => _inputController.stream;

  @override
  void publish(int value) => _inputController.sink.add(value);

  @override
  void dispose() {
    _inputController.close();
  }
}