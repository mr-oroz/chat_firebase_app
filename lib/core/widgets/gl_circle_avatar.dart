import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:chat_app_firebase/core/utils/random_gradient/random_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlCircleAvatar extends StatelessWidget {
  const GlCircleAvatar({
    super.key, required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: getRandomGradient(),
        ),
        child: Center(
          child: Text(
            username,
            style: AppStyles.w700f20.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
