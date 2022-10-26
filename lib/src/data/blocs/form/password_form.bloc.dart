import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/events/password_form.event.dart';
import 'package:cupcake/src/data/transformers/password_validator.transform.dart';
import 'package:rxdart/rxdart.dart';

class PasswordFormBloc implements Bloc<PasswordFormEvent, PasswordFormEvent> {
  final BehaviorSubject<PasswordFormEvent> _passwordController;
  final PasswordValidatorTransformer _transformer;

  PasswordFormBloc()
      : _passwordController = BehaviorSubject<PasswordFormEvent>(),
        _transformer = PasswordValidatorTransformer();

  @override
  PasswordFormEvent get lastEmittedValue => _passwordController.value;

  @override
  Stream<PasswordFormEvent> get stream =>
      _passwordController.stream.transform(_transformer.get());

  @override
  void publish(PasswordFormEvent value) => _passwordController.sink.add(value);

  @override
  void dispose() {
    _passwordController.close();
  }
}
