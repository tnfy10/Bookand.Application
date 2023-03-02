// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      providerEmail: json['providerEmail'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      providerType:
          $enumDecodeNullable(_$SocialTypeEnumMap, json['providerType']) ??
              SocialType.NONE,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'providerEmail': instance.providerEmail,
      'profileImage': instance.profileImage,
      'providerType': _$SocialTypeEnumMap[instance.providerType]!,
    };

const _$SocialTypeEnumMap = {
  SocialType.NONE: 'NONE',
  SocialType.GOOGLE: 'GOOGLE',
  SocialType.APPLE: 'APPLE',
};
