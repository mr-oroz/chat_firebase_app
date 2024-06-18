import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/utils/format_dates/format_date_ago.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.item,
    required this.alignPosition,
  });

  final Message item;
  final bool alignPosition;

  @override
  Widget build(BuildContext context) {
    final aligment =
        alignPosition ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bgColor = alignPosition ? AppColors.green : AppColors.stroke;
    final dateTime = formatDate(item.timestamp!);

    return Row(
      mainAxisAlignment: aligment,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(
            vertical: item.image != null ? 5 : 10,
            horizontal: item.image != null ? 5 : 15,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: alignPosition
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                  )
                : const BorderRadius.only(
                    bottomRight: Radius.circular(21),
                    topLeft: Radius.circular(21),
                    topRight: Radius.circular(21),
                  ),
          ),
          child: item.image != null
              ? Column(
                  crossAxisAlignment: alignPosition
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(21),
                            topRight: Radius.circular(21),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        child: Image.network(
                          item.image.toString(),
                          height: 160.h,
                          fit: BoxFit.cover,
                        )),
                    Row(
                      children: [
                        Text(
                          item.message.toString(),
                          style: AppStyles.w500f16.copyWith(
                            color: alignPosition
                                ? AppColors.darkGreen
                                : AppColors.black,
                          ),
                        ),
                        item.message.toString() != '' ? SizedBox(width: 140.w) : Container(),
                        Text(
                          dateTime,
                          style: AppStyles.w500f14.copyWith(
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.message}',
                      style: AppStyles.w500f14.copyWith(
                        color: alignPosition
                            ? AppColors.darkGreen
                            : AppColors.black,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      dateTime,
                      style: AppStyles.w500f14.copyWith(
                        color: AppColors.darkGreen,
                      ),
                    ),
                    alignPosition ? Icon(
                      item.seen != null && item.seen == true
                          ? Icons.done_all
                          : Icons.check,
                      size: 12,
                      color: AppColors.darkGrey,
                    ) : Container()
                  ],
                ),
        ),
      ],
    );
  }
}
