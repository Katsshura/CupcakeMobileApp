import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart';

part 'product.model.g.dart';

@JsonSerializable(explicitToJson: true, ignoreUnannotated: true)
class ProductModel {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'available_stock')
  int availableStock;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'image_url')
  String imageUrl;

  @JsonKey(name: 'price', fromJson: doubleToDecimal, toJson: decimalToDouble)
  Decimal price;

  @JsonKey(name: 'popularity', fromJson: doubleToDecimal, toJson: decimalToDouble)
  Decimal popularity;

  ProductModel(this.id, this.availableStock, this.name, this.description,
      this.imageUrl, this.price, this.popularity);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

Decimal doubleToDecimal(double value) => Decimal.parse(value.toString());
double decimalToDouble(Decimal value) => value.toDouble();