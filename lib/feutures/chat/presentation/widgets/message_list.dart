import 'package:chat_app_firebase/core/utils/by_days_of_separation/by_days_of_separation.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message_item_model.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/seen_message_bloc/seen_message_bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/widgets/widgets.dart';
import 'package:chat_app_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageList extends StatefulWidget {
  const MessageList({
    super.key,
    required this.message,
    required this.chatRoomId,
  });

  final List<Message> message;
  final String chatRoomId;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();
  late List<ListItem> items;
  @override
  void initState() {
    super.initState();
    items = buildItems(widget.message);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void didUpdateWidget(covariant MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != oldWidget.message) {
      items = buildItems(widget.message);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myUid = firebaseAuth.currentUser!.uid;
    return ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        reverse: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item is DateItem) {
            return LineDateWidget(item: item);
          } else if (item is MessageItemModel) {
            final isMyMessage = item.message.senderId == myUid;
            final messageIndex = widget.message.indexWhere(
              (msg) => msg.messageId == item.message.messageId,
            );
            final messages = widget.message[messageIndex];

            if (!isMyMessage) {
              context.read<SeenMessageBloc>().add(
                    SeenMessageEvent.seenMessage(
                      senderId: messages.senderId.toString(),
                      chatRoomId: widget.chatRoomId,
                      messageId: messages.messageId.toString(),
                    ),
                  );
            }
            return MessageItem(
              item: item.message,
              alignPosition: isMyMessage,
            );
          }
          return const SizedBox.shrink();
        });
  }
}
