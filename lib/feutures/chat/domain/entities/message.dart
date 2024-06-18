import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    String? message,
    String? messageId,
    String? senderId,
    String? receiverId,
    String? username,
    String? image,
    @TimestampConverter() Timestamp? timestamp,
    bool? seen,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  factory Message.fromStoreData(Map<String, dynamic> firestoreData) {
    return Message(
      message: firestoreData['message'] as String?,
      messageId: firestoreData['messageId'] as String?,
      senderId: firestoreData['senderId'] as String?,
      timestamp: firestoreData['timestamp'] as Timestamp?,
      seen: firestoreData['seen'] as bool?,
      username: firestoreData['username'] as String?,
      image: firestoreData['image'] as String?,
    );
  }
}