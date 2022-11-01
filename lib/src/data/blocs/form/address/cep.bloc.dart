import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/transformers/string_default_validator.transform.dart';
import 'package:rxdart/rxdart.dart';

class CEPBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _cepController;
  final StringDefaultValidatorTransformer _transformer;

  CEPBloc()
      : _cepController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(8);

  @override
  String get lastEmittedValue => _cepController.value;

  @override
  Stream<String> get stream =>
      _cepController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _cepController.sink.add(value);

  @override
  void dispose() {
    _cepController.close();
  }
}