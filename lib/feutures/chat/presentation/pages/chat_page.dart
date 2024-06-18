import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/widgets/widgets.dart';
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    context.read<GetAllChatsBloc>().add(const GetAllChatsEvent.getAllChatRoom());
    context.read<SignInBloc>().add(const SignInEvent.login(
        email: 'test@mail.ru', password: 'test1234'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Чаты', style: AppStyles.w600f32),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.stroke),
                ),
              ),
              child: GlTextField(
                onChanged: (value) {
                  context.read<GetAllChatsBloc>().add(GetAllChatsEvent.searchChat(query: value));
                },
                controller: searchCtrl,
                hintText: 'Поиск',
                pathIcon: 'assets/icons/search.svg',
              ),
            ),
            BlocBuilder<GetAllChatsBloc, GetAllChatsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (chatRooms) {
                    return ChatList(
                      chatRooms: chatRooms,
                    );
                  },
                  orElse: () => Container(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
