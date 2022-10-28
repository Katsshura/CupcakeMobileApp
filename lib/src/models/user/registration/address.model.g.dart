// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      json['cep'] as String,
      json['logradouro'] as String,
      json['property_number'] as String,
      json['complement'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'logradouro': instance.street,
      'property_number': instance.propertyNumber,
      'complement': instance.complement,
    };
