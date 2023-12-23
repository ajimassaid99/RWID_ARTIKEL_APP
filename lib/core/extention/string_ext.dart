import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

extension DialogExt on String {
  void succeedBar(BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      icon: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.check, color: AppColors.primary600)),
      backgroundColor: AppColors.primary600,
      shouldIconPulse: false,
      message: this,
      duration: const Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          )),
      borderRadius: BorderRadius.circular(50),
    ).show(context);
  }

  void failedBar(BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      icon: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.warning, color: AppColors.error500)),
      backgroundColor: AppColors.error500,
      shouldIconPulse: false,
      message: this,
      duration: const Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: IconButton(
          onPressed: () {
            FlushbarDismissDirection.HORIZONTAL;
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          )),
      borderRadius: BorderRadius.circular(50),
    ).show(context);
  }
}

