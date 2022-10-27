import 'dart:async';

import 'package:cupcake/src/data/blocs/bloc.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc implements Bloc<UserTokenEvent, UserTokenEvent?> {
  static const String tokenKey = 'saved_jwt';
  static const String tokenTypeKey = 'saved_type';

  final _userBloc = BehaviorSubject<UserTokenEvent>();
  SharedPreferences? _sharedPreferences;

  UserBloc() {
    _initSharedPreferences();
  }

  @override
  UserTokenEvent? get lastEmittedValue  {
    if (!_userBloc.hasValue) {
      final savedToken = _sharedPreferences?.getString(tokenKey);
      final savedType = _sharedPreferences?.getString(tokenTypeKey);

      if (savedToken == null || savedType == null) return null;

      final userTokenEvent = UserTokenEvent(savedToken, savedType);
      publish(userTokenEvent);
      return userTokenEvent;
    }

    return _userBloc.value;
  }

  @override
  Stream<UserTokenEvent> get stream =>
      _userBloc.stream.transform(_buildTransformer());

  @override
  void publish(UserTokenEvent value) {
    _userBloc.sink.add(value);
  }

  @override
  void dispose() {
    _userBloc.close();
    _sharedPreferences?.clear();
  }

  void _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  StreamTransformer<UserTokenEvent, UserTokenEvent> _buildTransformer() {
    return StreamTransformer.fromHandlers(
      handleData: (data, publisher) {
        if (data.token?.isEmpty == true || data.type?.isEmpty == true) {
          publisher.addError('Invalid User Token!');
          return;
        }

        _sharedPreferences?.setString(tokenKey, data.token!);
        _sharedPreferences?.setString(tokenTypeKey, data.type!);
        publisher.add(data);
      },
    );
  }
}
