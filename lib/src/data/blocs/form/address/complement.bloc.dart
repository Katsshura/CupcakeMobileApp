import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ComplementBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _complementController;

  ComplementBloc() : _complementController = BehaviorSubject<String>();

  @override
  String get lastEmittedValue => _complementController.value;

  @override
  Stream<String> get stream => _complementController.stream;

  @override
  void publish(String value) => _complementController.sink.add(value);

  @override
  void dispose() {
    _complementController.close();
  }
}
