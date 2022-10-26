import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/transformers/email_validation.transformer.dart';
import 'package:rxdart/rxdart.dart';

class EmailFormBloc implements Bloc<String, String> {
  final BehaviorSubject<String> _emailController;
  final EmailValidationTransformer _transformer;

  EmailFormBloc()
      : _emailController = BehaviorSubject<String>(),
        _transformer = EmailValidationTransformer();

  @override
  String get lastEmittedValue => _emailController.value;

  @override
  Stream<String> get stream =>
      _emailController.stream.transform(_transformer.get());

  @override
  void publish(String value) => _emailController.sink.add(value);

  @override
  void dispose() {
    _emailController.close();
  }
}
