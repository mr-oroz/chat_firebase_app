import 'package:chat_app_firebase/core/utils/random_gradient/random_gradient.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/widgets/widgets.dart';
import 'package:chat_app_firebase/main.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chatRooms});

  final List<ChatRoom> chatRooms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final myUid = firebaseAuth.currentUser!.uid;
        final chat = chatRooms.elementAt(index);
        final userId = chat.members!.firstWhere(
          (userId) => userId != myUid,
        );
        return ChatItem(
          item: chat,
          userId: userId,
          getRandomGradient: getRandomGradient,
        );
      },
      itemCount: chatRooms.length,
    );
  }
}
