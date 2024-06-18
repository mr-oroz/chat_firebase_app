import 'dart:typed_data';

import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/utils/utils.dart';
import 'package:chat_app_firebase/core/widgets/widgets.dart';
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/get_all_users_bloc.dart/get_all_users_bloc.dart';
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/widgets/modal_input.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({super.key, this.uid});

  final String? uid;

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  final TextEditingController messageCtrl = TextEditingController();
  Uint8List? file;
  @override
  void initState() {
    context.read<GetUserBloc>().add(
          GetUserEvent.getUser(
            uid: widget.uid.toString(),
          ),
        );
    super.initState();
  }

  Future<void> selectedImage(String chatRoomId) async {
    file = await pickImage(context);
    setState(() {});
    if (file != null) {
      showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ModalInput(
            imageFile: file!,
            userId: widget.uid.toString(),
            chatRoomId: chatRoomId,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    messageCtrl.dispose();
    super.dispose();
  }

  void sendMessage(String chatRoomId) {
    if (messageCtrl.text.isNotEmpty) {
      context.read<SendMessageBloc>().add(
            SendMessageEvent.sendMessage(
              chatRoomId: chatRoomId.toString(),
              message: messageCtrl.text,
              receiverId: widget.uid.toString(),
            ),
          );
    }
    messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserBloc, GetUserState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            context.read<CreateChatRoomBloc>().add(
                  CreateChatRoomEvent.createChatRoom(
                    receiverUsername: user.username.toString(),
                    uid: user.uid.toString(),
                  ),
                );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ),
            ),
          ),
          success: (user) {
            final lastSeen = user.lastMessageTs != null
                ? formatDateStatusUser(user.lastMessageTs!)
                : 'Неизвестно';
            final formatUserName = usernameFormat(user.username.toString());
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(
                  size: 18,
                  color: AppColors.black,
                ),
                centerTitle: false,
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GlCircleAvatar(
                    username: formatUserName,
                  ),
                  title: Text(
                    user.username.toString(),
                    style: AppStyles.w600f15,
                  ),
                  subtitle: Text(
                    lastSeen,
                    style: AppStyles.w500f12.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: BlocConsumer<CreateChatRoomBloc, CreateChatRoomState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (chatRoomId) {
                        context.read<GetMessagesBloc>().add(
                              GetMessagesEvent.getMessages(
                                  chatRoomId: chatRoomId),
                            );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      success: (chatRoomId) {
                        return Column(
                          children: [
                            SizedBox(height: 10.h),
                            Divider(
                              color: AppColors.stroke,
                              height: 1.h,
                            ),
                            // message list
                            Expanded(
                              flex: 20,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                                child: BlocBuilder<GetMessagesBloc,
                                    GetMessagesState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      success: (messages) {
                                        return MessageList(
                                          chatRoomId: chatRoomId,
                                          message: messages,
                                        );
                                      },
                                      orElse: () => Container(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // send message
                            const Spacer(),
                            _buildSendMessage(chatRoomId)
                          ],
                        );
                      },
                      orElse: () => Container(),
                    );
                  },
                ),
              ),
            );
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Container _buildSendMessage(String chatRoomId) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.stroke,
          ),
        ),
      ),
      child: BlocListener<SendMessageBloc, SendMessageState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              context
                  .read<GetAllUsersBloc>()
                  .add(const GetAllUsersEvent.getAllUsers());
            },
            orElse: () {},
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GlIconButton(
                icon: const Icon(Icons.attach_file_outlined),
                onPressed: () => selectedImage(chatRoomId.toString()),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: GlTextField(
                  onSubmit: (value) {
                    sendMessage(chatRoomId);
                  },
                  controller: messageCtrl,
                  hintText: 'Сообщение',
                ),
              ),
            ),
            Expanded(
              child: GlIconButton(
                icon: const Icon(Icons.mic_none_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
