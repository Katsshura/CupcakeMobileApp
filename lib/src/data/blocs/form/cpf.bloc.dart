import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../transformers/string_default_validator.transform.dart';

class CPFBloc implements Bloc<String, String> {

  final BehaviorSubject<String> _cpfController;
  final StringDefaultValidatorTransformer _transformer;

  CPFBloc()
      : _cpfController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(11);

  @override
  String get lastEmittedValue => _cpfController.value;

  @override
  Stream<String> get stream =>
      _cpfController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _cpfController.sink.add(value);

  @override
  void dispose() {
    _cpfController.close();
  }
}