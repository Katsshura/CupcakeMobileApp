import 'package:json_annotation/json_annotation.dart';

part 'order_status.model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class OrderStatusModel {
  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'active')
  bool active;

  OrderStatusModel(this.status, this.active);

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusModelToJson(this);
}