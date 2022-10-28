import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../transformers/string_default_validator.transform.dart';

class BirthdayBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _birthdayController;
  final StringDefaultValidatorTransformer _transformer;

  BirthdayBloc()
      : _birthdayController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(8);

  @override
  String get lastEmittedValue => _birthdayController.value;

  @override
  Stream<String> get stream =>
      _birthdayController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _birthdayController.sink.add(value);

  @override
  void dispose() {
    _birthdayController.close();
  }
}