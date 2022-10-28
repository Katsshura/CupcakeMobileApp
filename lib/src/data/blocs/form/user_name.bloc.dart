import 'package:rxdart/rxdart.dart';

import '../../transformers/string_default_validator.transform.dart';
import '../bloc.dart';

class UserNameBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _stringController;
  final StringDefaultValidatorTransformer _transformer;

  UserNameBloc()
      : _stringController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(3);

  @override
  String get lastEmittedValue => _stringController.value;

  @override
  Stream<String> get stream =>
      _stringController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _stringController.sink.add(value);

  @override
  void dispose() {
    _stringController.close();
  }
}
