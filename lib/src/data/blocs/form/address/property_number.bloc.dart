import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/transformers/string_default_validator.transform.dart';
import 'package:rxdart/rxdart.dart';

class PropertyNumberBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _propertyNumberController;
  final StringDefaultValidatorTransformer _transformer;

  PropertyNumberBloc()
      : _propertyNumberController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(1);

  @override
  String get lastEmittedValue => _propertyNumberController.value;

  @override
  Stream<String> get stream =>
      _propertyNumberController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _propertyNumberController.sink.add(value);

  @override
  void dispose() {
    _propertyNumberController.close();
  }
}