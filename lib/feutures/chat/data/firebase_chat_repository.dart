import 'dart:typed_data';

import 'package:chat_app_firebase/core/utils/firebase_download_url/firebase_download_url.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IChatRepository)
class FirebaseChatRepository implements IChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  FirebaseChatRepository(this.auth, this.firestore, this.storage);

  @override
  Future<String> createChatRoom({
    required String receiverUsername,
    required String uid,
    required String senderUsername,
  }) async {
    try {
      final String currentUid = auth.currentUser!.uid;
      final CollectionReference chatrooms = firestore.collection('chatrooms');
      final sortedMembers = [currentUid, uid]..sort((a, b) => a.compareTo(b));
      final QuerySnapshot existingChatrooms = await chatrooms
          .where(
            'members',
            isEqualTo: sortedMembers,
          )
          .get();
      if (existingChatrooms.docs.isNotEmpty) {
        return existingChatrooms.docs.first.id;
      } else {
        final chatRoomId = const Uuid().v1();
        final now = Timestamp.now();
        final ChatRoom chatRoom = ChatRoom(
          chatRoomId: chatRoomId,
          lastMessage: '',
          lastMessageTs: now,
          members: sortedMembers,
          createdAt: now,
          lastSenderId: '',
          receiverId: uid,
          receiverUsername: receiverUsername,
          senderUsername: senderUsername,
        );
        await firestore
            .collection('chatrooms')
            .doc(chatRoomId)
            .set(chatRoom.toJson());
        return chatRoomId;
      }
    } catch (e) {
      // ignore: avoid_print
      print('error ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<Message>> getMessages({required String chatRoomId}) {
    return firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Message.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<ChatRoom>> getAllChats() {
    final myUid = auth.currentUser!.uid;
    return firestore
        .collection('chatrooms')
        .where('members', arrayContains: myUid)
        .orderBy('lastMessageTs', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatRoom.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<String?> seenMessage(
      {required String chatRoomId, required String senderId}) async {
    try {
      final messagesQuery = await firestore
          .collection('chatrooms')
          .doc(chatRoomId)
          .collection('messages')
          .where('senderId', isEqualTo: senderId)
          .where('seen', isEqualTo: false)
          .get();
      if (messagesQuery.docs.isEmpty) {
        return null;
      }
      final batch = firestore.batch();
      for (final doc in messagesQuery.docs) {
        batch.update(doc.reference, {'seen': true});
      }
      await batch.commit();
      await firestore
          .collection('chatrooms')
          .doc(chatRoomId)
          .update({'seen': true});

      return null;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> sendMessage({
    required String message,
    required String chatRoomId,
    required String receiverId,
    Uint8List? file,
  }) async {
    try {
      final messageId = const Uuid().v1();
      final now = Timestamp.now();
      final String currentUid = auth.currentUser!.uid;
      final Message newMessage = Message(
        message: message,
        messageId: messageId,
        senderId: currentUid,
        receiverId: receiverId,
        timestamp: now,
        seen: false,
      );

      final DocumentReference myChatRoomRef =
          firestore.collection('chatrooms').doc(chatRoomId);
      if (file != null) {
        final imageUrl = await FirebaseDownloadUrl(auth, storage)
            .uploadImageToStorage('chatrooms', file, true);
        final updateMessage = newMessage.copyWith(
          image: imageUrl,
        );
        await myChatRoomRef
            .collection('messages')
            .doc(messageId)
            .set(updateMessage.toJson());
      } else {
        await myChatRoomRef
            .collection('messages')
            .doc(messageId)
            .set(newMessage.toJson());
      }
      if (currentUid != receiverId) {
        await myChatRoomRef.update({
          'lastMessage': message,
          'lastMessageTs': now,
          'seen': false,
          'lastSenderId': currentUid,
        });
        await firestore.collection('users').doc(receiverId).update({
          'lastMessage': message,
          'lastMessageTs': now,
        });
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
