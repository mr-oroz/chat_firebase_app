import 'dart:math';

import 'package:chat_app_firebase/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

  final Random random = Random();
  List<Gradient> gradient = [
    AppStyles.greenGradient,
    AppStyles.redGradient,
    AppStyles.blueGradient,
  ];
  
  Gradient getRandomGradient() {
    return gradient[random.nextInt(gradient.length)];
  }
