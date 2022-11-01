import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/transformers/string_default_validator.transform.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _addressController;
  final StringDefaultValidatorTransformer _transformer;

  AddressBloc()
      : _addressController = BehaviorSubject<String>(),
        _transformer = StringDefaultValidatorTransformer(4);

  @override
  String get lastEmittedValue => _addressController.value;

  @override
  Stream<String> get stream =>
      _addressController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _addressController.sink.add(value);

  @override
  void dispose() {
    _addressController.close();
  }
}