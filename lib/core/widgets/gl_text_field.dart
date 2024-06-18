// ignore_for_file: deprecated_member_use

import 'package:chat_app_firebase/core/theme/app_colors.dart';
import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GlTextField extends StatelessWidget {
  const GlTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.pathIcon, this.onSubmit, this.onChanged});
  final TextEditingController controller;
  final String hintText;
  final String? pathIcon;
  final Function(String value)? onSubmit;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal:pathIcon == null ? 10 : 0),
      height: 42.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.stroke,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          
          hintStyle: AppStyles.w500f16.copyWith(color: AppColors.grey),
          prefixIcon: pathIcon != null ? Container(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              pathIcon!,
              width: 24.w,
              height: 24.h,
              color: AppColors.grey,
            ),
          ) : null,
          prefixIconColor: AppColors.grey,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
