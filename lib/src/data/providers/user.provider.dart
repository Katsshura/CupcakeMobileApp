import 'package:cupcake/src/data/blocs/user.bloc.dart';
import 'package:flutter/material.dart';

class UserProvider extends InheritedWidget {
  final UserBloc _userBloc;

  UserProvider({super.key, required super.child}) : _userBloc = UserBloc();

  @override
  bool updateShouldNotify(_) => true;

  static UserProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UserProvider>()!;

  static UserBloc ofUser(BuildContext context) =>
      _ofProvider(context)._userBloc;
}
