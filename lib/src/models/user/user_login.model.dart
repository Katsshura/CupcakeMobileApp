import 'package:json_annotation/json_annotation.dart';

part 'user_login.model.g.dart';

@JsonSerializable()
class UserLoginModel {
  String email;
  String password;

  UserLoginModel(this.email, this.password);

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}