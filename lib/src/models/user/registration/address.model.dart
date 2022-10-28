import 'package:json_annotation/json_annotation.dart';

part 'address.model.g.dart';

@JsonSerializable()
class AddressModel {
  @JsonKey(name: 'cep')
  final String cep;

  @JsonKey(name: 'logradouro')
  final String street;

  @JsonKey(name: 'property_number')
  final String propertyNumber;

  @JsonKey(name: 'complement')
  final String complement;

  AddressModel(this.cep, this.street, this.propertyNumber, this.complement);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}