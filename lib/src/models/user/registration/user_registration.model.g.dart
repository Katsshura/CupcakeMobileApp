// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationModel _$UserRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    UserRegistrationModel(
      json['email'] as String,
      json['name'] as String,
      json['cpf'] as String,
      json['password'] as String,
      json['birthday_date'] as String,
      (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRegistrationModelToJson(
        UserRegistrationModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'cpf': instance.cpf,
      'birthday_date': instance.birthdayDate,
      'password': instance.password,
      'addresses': instance.addressModel?.map((e) => e.toJson()).toList(),
    };
