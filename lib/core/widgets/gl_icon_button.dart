
import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlIconButton extends StatelessWidget {
  const GlIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Icon icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 42.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.stroke, borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onPressed,
        child: icon,
      ),
    );
  }
}
