import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/models/product/highlight/highlight.model.dart';
import 'package:rxdart/rxdart.dart';

class HighlightBloc
    implements Bloc<Future<HighlightModel>, Future<HighlightModel>> {

  final BehaviorSubject<Future<HighlightModel>> _controller;

  HighlightBloc() : _controller = BehaviorSubject<Future<HighlightModel>>();

  @override
  Future<HighlightModel> get lastEmittedValue => _controller.value;

  @override
  Stream<Future<HighlightModel>> get stream => _controller.stream;

  @override
  void publish(Future<HighlightModel> value) => _controller.sink.add(value);

  @override
  void dispose() {
    _controller.close();
  }
}
