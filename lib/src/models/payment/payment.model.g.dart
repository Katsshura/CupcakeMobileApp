// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      json['card_number'] as String,
      json['expiring_date'] as String,
      json['cvv'] as int,
      json['custom_name'] as String,
      json['card_flag'] as String,
      json['id'] as int?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['card_number'] = instance.cardNumber;
  val['expiring_date'] = instance.expiringDate;
  val['cvv'] = instance.cvv;
  val['custom_name'] = instance.customName;
  val['card_flag'] = instance.cardFlag;
  return val;
}
