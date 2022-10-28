import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/data/blocs/form/user_name.bloc.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:cupcake/src/services/user.service.dart';
import 'package:flutter/material.dart';

import '../blocs/form/birthday.bloc.dart';
import '../blocs/form/cpf.bloc.dart';
import '../blocs/form/email_form.bloc.dart';
import '../blocs/form/password_form.bloc.dart';
import 'package:rxdart/rxdart.dart' as rx;

class RegistrationScreenProvider extends InheritedWidget {
  static final UserService _userService = UserService();

  final UserNameBloc _userNameBloc;
  final EmailFormBloc _emailBloc;
  final PasswordFormBloc _passwordBloc;
  final CPFBloc _cpfBloc;
  final BirthdayBloc _birthdayBloc;

  RegistrationScreenProvider({super.key, required super.child})
      : _userNameBloc = UserNameBloc(),
        _emailBloc = EmailFormBloc(),
        _passwordBloc = PasswordFormBloc(),
        _cpfBloc = CPFBloc(),
        _birthdayBloc = BirthdayBloc();

  @override
  bool updateShouldNotify(_) => true;

  static RegistrationScreenProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RegistrationScreenProvider>()!;

  static UserNameBloc ofName(BuildContext context) =>
      _ofProvider(context)._userNameBloc;

  static PasswordFormBloc ofPassword(BuildContext context) =>
      _ofProvider(context)._passwordBloc;

  static EmailFormBloc ofEmail(BuildContext context) =>
      _ofProvider(context)._emailBloc;

  static CPFBloc ofCpf(BuildContext context) => _ofProvider(context)._cpfBloc;

  static BirthdayBloc ofBirthday(BuildContext context) =>
      _ofProvider(context)._birthdayBloc;

  static Stream<UserRegistrationModel> ofUserRegistrationModel(
      BuildContext context) {
    final userNameStream = ofName(context).stream;
    final emailStream = ofEmail(context).stream;
    final passwordStream = ofPassword(context).stream;
    final cpfStream = ofCpf(context).stream;
    final birthdayStream = ofBirthday(context).stream;

    return rx.CombineLatestStream.combine5(
      userNameStream,
      emailStream,
      passwordStream,
      cpfStream,
      birthdayStream,
      (name, email, password, cpf, birthday) =>
          UserRegistrationModel(email, name, cpf, password.password!, cpf),
    );
  }
}
