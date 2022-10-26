import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/form/email_form.bloc.dart';
import 'package:cupcake/src/data/blocs/form/password_form.bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart' as rx;

class LoginScreenProvider extends InheritedWidget {
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

  static void submitForm(BuildContext context) async {
    final email = ofEmail(context).lastEmittedValue;
    final password = ofPassword(context).lastEmittedValue.password!;

    final errorToast = ToastBuilder.buildErrorToast(TextConstants.formSubmitErrorMessage);
    _showToast(errorToast);
    print('User Login, Email: [$email] | Password: [$password]');
  }

  static void _showToast(Widget toast) {
    final fToast = FToast();
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 5),
    );
  }
}
