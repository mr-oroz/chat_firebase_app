import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/utils/format_dates/format_date_ago.dart';
import 'package:chat_app_firebase/core/utils/username_format/username_format.dart';
import 'package:chat_app_firebase/core/widgets/widgets.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/pages/sub_pages/sub_pages.dart';
import 'package:chat_app_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.getRandomGradient,
    required this.item,
    required this.userId,
  });

  final Gradient Function() getRandomGradient;
  final ChatRoom item;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final formdate = item.lastMessageTs != null
        ? formatDate(item.lastMessageTs!)
        : 'Неизвестно';
    final formatUserName = usernameFormat(item.receiverUsername.toString());
    final currentUid = firebaseAuth.currentUser!.uid;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailChatPage(
                uid: userId,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: GlCircleAvatar(username: formatUserName),
                title: Text(
                  '${currentUid != item.receiverId ? item.receiverUsername : item.senderUsername}',
                  style: AppStyles.w600f15,
                ),
                subtitle: currentUid == item.lastSenderId
                    ? Row(
                        children: [
                          Text(
                            'Вы:',
                            style: AppStyles.w500f12,
                          ),
                          Text(
                            '${item.lastMessage}',
                            style: AppStyles.w500f12.copyWith(
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${item.lastMessage}',
                        style: AppStyles.w500f12.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      formdate,
                      style: AppStyles.w500f12.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: AppColors.stroke,
              height: 1.h,
            )
          ],
        ),
      ),
    );
  }
}
