
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';



helloSnack(String title, String msg) => Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.TOP,

      margin: const EdgeInsets.all(20),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      messageText: Text(msg, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );

errorSnack(String msg) => Get.snackbar(
      'ERROR',
      msg,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.primaryColor,
      snackStyle: SnackStyle.FLOATING,
      titleText: const Text('ERROR', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      messageText: Text(msg, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );

alertSnack(String msg) => Get.snackbar(
      'ALERT',
      msg,
      margin: const EdgeInsets.all(20),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.yellow,
      snackStyle: SnackStyle.FLOATING,

      titleText: const Text('ALERT', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
      messageText: Text(msg, style: const TextStyle(color: Colors.black, fontSize: 14)),
    );

successSnack(String msg) => Get.snackbar(
      'SUCCESS',
      msg,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      snackStyle: SnackStyle.FLOATING,

      titleText: const Text('SUCCESS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      messageText: Text(msg, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
