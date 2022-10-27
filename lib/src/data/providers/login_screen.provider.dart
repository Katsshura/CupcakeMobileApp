import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/form/email_form.bloc.dart';
import 'package:cupcake/src/data/blocs/form/password_form.bloc.dart';
import 'package:cupcake/src/data/events/login.event.dart';
import 'package:cupcake/src/data/providers/user.provider.dart';
import 'package:cupcake/src/models/user/user_login.model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart' as rx;

import '../../services/user.service.dart';

class LoginScreenProvider extends InheritedWidget {
  static final UserService _userService = UserService();

  final EmailFormBloc _emailBloc;
  final PasswordFormBloc _passwordBloc;

  LoginScreenProvider({super.key, required super.child})
      : _emailBloc = EmailFormBloc(),
        _passwordBloc = PasswordFormBloc();

  @override
  bool updateShouldNotify(_) => true;

  static LoginScreenProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LoginScreenProvider>()!;

  static EmailFormBloc ofEmail(BuildContext context) =>
      _ofProvider(context)._emailBloc;

  static PasswordFormBloc ofPassword(BuildContext context) =>
      _ofProvider(context)._passwordBloc;

  static Stream<bool> isSubmitValid(BuildContext context) {
    final emailStream = ofEmail(context).stream;
    final passwordStream = ofPassword(context).stream;
    return rx.CombineLatestStream.combine2(
        emailStream, passwordStream, (a, b) => true);
  }

  static void submitForm(BuildContext context, String redirectPath) {
    final email = ofEmail(context).lastEmittedValue;
    final password = ofPassword(context).lastEmittedValue.password!;

    _userService.login(UserLoginModel(email, password)).then((value) {
      UserProvider.ofUser(context)
          .publish(UserTokenEvent(value.accessToken, value.tokenType));
      Navigator.pushNamed(context, redirectPath);
    }).catchError(
      (error) {
        _showErrorToast(context);
      },
    );
  }

  static void _showErrorToast(BuildContext context) {
    final errorToast =
        ToastBuilder.buildErrorToast(TextConstants.formSubmitErrorMessage);
    _showToast(errorToast, context);
  }

  static void _showToast(Widget toast, BuildContext context) {
    final fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 5),
    );
  }
}
