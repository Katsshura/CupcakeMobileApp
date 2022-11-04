import 'package:cupcake/src/models/product/product.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'highlight.model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class HighlightModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'subtitle')
  String subtitle;

  @JsonKey(name: 'product')
  ProductModel product;

  HighlightModel(
      this.id, this.enabled, this.title, this.subtitle, this.product);

  factory HighlightModel.fromJson(Map<String, dynamic> json) =>
      _$HighlightModelFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightModelToJson(this);
}