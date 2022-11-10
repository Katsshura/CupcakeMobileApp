import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/transformers/string_default_validator.transform.dart';
import 'package:rxdart/rxdart.dart';

class CardCVVBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _stringController;
  final StringDefaultValidatorTransformer _transformer;

  CardCVVBloc()
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
