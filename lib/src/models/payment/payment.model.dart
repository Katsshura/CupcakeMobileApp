import 'package:json_annotation/json_annotation.dart';

part 'payment.model.g.dart';

@JsonSerializable(ignoreUnannotated: true, includeIfNull: false)
class PaymentModel {

  @JsonKey(name: 'id', includeIfNull: false)
  int? id;

  @JsonKey(name: 'card_number')
  String cardNumber;

  @JsonKey(name: 'expiring_date')
  String expiringDate;

  @JsonKey(name: 'cvv')
  int cvv;

  @JsonKey(name: 'custom_name')
  String customName;

  @JsonKey(name: 'card_flag')
  String cardFlag;

  PaymentModel(this.cardNumber, this.expiringDate, this.cvv,
      this.customName, this.cardFlag, [this.id]);

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}