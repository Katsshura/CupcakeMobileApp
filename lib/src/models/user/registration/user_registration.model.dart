import 'package:cupcake/src/models/user/registration/address.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_registration.model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRegistrationModel {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'cpf')
  final String cpf;

  @JsonKey(name: 'birthday_date')
  final String birthdayDate;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'addresses')
  final List<AddressModel>? addressModel;

  UserRegistrationModel(this.email, this.name, this.cpf, this.password, this.birthdayDate, [this.addressModel]);

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationModelToJson(this);
}
