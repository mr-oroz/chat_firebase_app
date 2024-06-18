import 'dart:typed_data';

import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';

abstract class IChatRepository {
  Future<String> createChatRoom({
    required String receiverUsername,
    required String senderUsername,
    required String uid,

  });
  Future<String?> sendMessage({
    required String message,
    required String chatRoomId,
    required String receiverId,
    Uint8List? file,
  });

  Future<String?> seenMessage({
    required String chatRoomId,
    required String senderId,
  });

  Stream<List<Message>> getMessages({
    required String chatRoomId,
  });
  Stream<List<ChatRoom>> getAllChats();
}
