
import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/utils/format_dates/format_date_chat.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message_item_model.dart';
import 'package:flutter/material.dart';

class LineDateWidget extends StatelessWidget {
  const LineDateWidget({
    super.key,
    required this.item,
  });

  final DateItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              formatDateChat(item.date),
              style: AppStyles.w500f14.copyWith(color: AppColors.grey),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
