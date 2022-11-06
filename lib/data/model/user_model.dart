import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError implements UserModelBase {
  final String message;

  UserModelError({required this.message});
}

class UserModelLoading implements UserModelBase {}

@JsonSerializable()
class UserModel implements UserModelBase {
  final String email;
  final String nickname;
  final String providerEmail;

  UserModel({required this.email, required this.nickname, required this.providerEmail});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}