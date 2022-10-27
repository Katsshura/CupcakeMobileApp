import 'package:json_annotation/json_annotation.dart';

part 'user_token.model.g.dart';

@JsonSerializable()
class UserTokenModel {
  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'token_type')
  String tokenType;

  UserTokenModel(this.accessToken, this.tokenType);

  factory UserTokenModel.fromJson(Map<String, dynamic> json) =>
      _$UserTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenModelToJson(this);
}