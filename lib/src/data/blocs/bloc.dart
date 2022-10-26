abstract class Bloc<Input, Output> {
  Output get lastEmittedValue;
  Stream<Output> get stream;
  void publish(Input value);
  void dispose();
}