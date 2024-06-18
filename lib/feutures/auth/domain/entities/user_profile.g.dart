// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      email: json['email'] as String?,
      username: json['username'] as String?,
      uid: json['uid'] as String?,
      lastMessage: json['lastMessage'] as String?,
      senderUid: json['senderUid'] as String?,
      lastMessageTs: const TimestampConverter().fromJson(json['lastMessageTs']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'uid': instance.uid,
      'lastMessage': instance.lastMessage,
      'senderUid': instance.senderUid,
      'lastMessageTs':
          const TimestampConverter().toJson(instance.lastMessageTs),
    };
