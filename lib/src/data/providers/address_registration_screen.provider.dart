import 'package:cupcake/src/builders/toast.builder.dart';
import 'package:cupcake/src/consts/routes_path.const.dart';
import 'package:cupcake/src/consts/text.const.dart';
import 'package:cupcake/src/data/blocs/form/address/address.bloc.dart';
import 'package:cupcake/src/data/blocs/form/address/cep.bloc.dart';
import 'package:cupcake/src/data/blocs/form/address/complement.bloc.dart';
import 'package:cupcake/src/data/blocs/form/address/property_number.bloc.dart';
import 'package:cupcake/src/models/user/registration/address.model.dart';
import 'package:cupcake/src/models/user/registration/user_registration.model.dart';
import 'package:cupcake/src/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart' as rx;

class AddressRegistrationScreenProvider extends InheritedWidget {
  static final UserService _userService = UserService();

  final AddressBloc _addressBloc;
  final CEPBloc _cepBloc;
  final ComplementBloc _complementBloc;
  final PropertyNumberBloc _propertyNumberBloc;

  AddressRegistrationScreenProvider({super.key, required super.child})
      : _addressBloc = AddressBloc(),
        _cepBloc = CEPBloc(),
        _complementBloc = ComplementBloc(),
        _propertyNumberBloc = PropertyNumberBloc();

  @override
  bool updateShouldNotify(_) => true;

  static AddressRegistrationScreenProvider _ofProvider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<
          AddressRegistrationScreenProvider>()!;

  static AddressBloc ofAddress(BuildContext context) =>
      _ofProvider(context)._addressBloc;

  static CEPBloc ofCep(BuildContext context) => _ofProvider(context)._cepBloc;

  static ComplementBloc ofComplement(BuildContext context) =>
      _ofProvider(context)._complementBloc;

  static PropertyNumberBloc ofPropertyNumber(BuildContext context) =>
      _ofProvider(context)._propertyNumberBloc;

  static Stream<bool> ofAddressModel(BuildContext context) {
    final addressStream = ofAddress(context).stream;
    final cepStream = ofCep(context).stream;
    final complementStream = ofComplement(context).stream;
    final propertyNumberStream = ofPropertyNumber(context).stream;

    return rx.CombineLatestStream.combine4(
        addressStream,
        cepStream,
        complementStream,
        propertyNumberStream,
        (address, cep, complement, propertyNumber) => true);
  }

  static void submitForm(BuildContext context, String redirectPath,
      UserRegistrationModel userModel) {
    final cep = ofCep(context).lastEmittedValue.replaceAll('-', '');
    final address = ofAddress(context).lastEmittedValue;
    final propertyNumber = ofPropertyNumber(context).lastEmittedValue;
    final complement = ofComplement(context).lastEmittedValue;

    final formattedCpf = userModel.cpf.replaceAll('.', '').replaceAll('-', '');
    final body = UserRegistrationModel(
        userModel.email,
        userModel.name,
        formattedCpf,
        userModel.password,
        userModel.birthdayDate,
        [AddressModel(cep, address, propertyNumber, complement)]);

    _userService.registerUser(body).then((value) {
      ToastBuilder.showSuccessToast(
          context, TextConstants.successOnRegisterUserMessage);
      return Navigator.pushNamed(context, RoutesPath.login,
          arguments: RoutesPath.home);
    }).catchError((error) {
      ToastBuilder.showErrorToast(context, error.toString());
    });
  }
}
