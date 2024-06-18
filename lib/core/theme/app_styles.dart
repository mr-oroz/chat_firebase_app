import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyles {
  static  TextStyle w700f20 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 20.sp, fontWeight: FontWeight.w700);
  static  TextStyle w600f32 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 32.sp, fontWeight: FontWeight.w600);
  static  TextStyle w600f15 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 15.sp, fontWeight: FontWeight.w600);
  static  TextStyle w500f16 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 16.sp, fontWeight: FontWeight.w500);
  static  TextStyle w500f14 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 14.sp, fontWeight: FontWeight.w500);
  static  TextStyle w500f12 = TextStyle(
      fontFamily: 'Gilroy', fontSize: 12.sp, fontWeight: FontWeight.w500);
  static  const LinearGradient redGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFF66700), Color(0xFFEC3800)],
  );
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF00ACF6), Color(0xFF006CEC)],
  );
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF1EDA5E), Color(0xFF31C764)],
  );
}
