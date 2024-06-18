import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? email,
    String? username,
    String? uid,
    String? lastMessage,
    String? senderUid,
    @TimestampConverter() Timestamp? lastMessageTs,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.fromStoreData(Map<String, dynamic> firestoreData) {
    return UserProfile(
      email: firestoreData['email'] as String?,
      username: firestoreData['username'] as String?,
      uid: firestoreData['uid'] as String?,
      lastMessage: firestoreData['lastMessage'] as String?,
      lastMessageTs: firestoreData['lastMessageTs'] as Timestamp?,
      senderUid: firestoreData['senderUid'] as String?,
    );
  }
}
