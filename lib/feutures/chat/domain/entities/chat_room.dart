import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    String? chatRoomId,
    String? lastMessage,
    String? lastSenderId,
    String? receiverId,
    String? receiverUsername,
    @TimestampConverter() Timestamp? lastMessageTs,
    List<String>? members,
    @TimestampConverter() Timestamp? createdAt,
    bool? seen,
  }) = _ChatRoom;
  
  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  factory ChatRoom.fromStoreData(Map<String, dynamic> firestoreData) {
    return ChatRoom(
      chatRoomId: firestoreData['chatRoomId'] as String?,
      receiverId: firestoreData['receiverId'] as String?,
      receiverUsername: firestoreData['receiverUsername'] as String?,
      lastMessage: firestoreData['lastMessage'] as String?,
      lastSenderId: firestoreData['lastSenderId'] as String?,
      lastMessageTs: firestoreData['lastMessageTs'] as Timestamp?,
      members: (firestoreData['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: firestoreData['createdAt'] as Timestamp?,
      seen: firestoreData['seen'] as bool?,
    );
  }
}

class TimestampConverter implements JsonConverter<Timestamp?, dynamic> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return json is Timestamp ? json : null;
  }

  @override
  dynamic toJson(Timestamp? timestamp) {
    return timestamp;
  }
}
