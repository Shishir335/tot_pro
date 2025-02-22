import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  String language = 'en';

  @override
  void onInit() {
    changeLanguage(language);
    super.onInit();
  }

  void changeLanguage(String value) {
    language = value;
    Locale locale =
        language == 'en' ? const Locale('en', 'US') : const Locale('ro', 'RO');
    Get.updateLocale(locale);
    EasyLocalization.of(Get.context!)!.setLocale(locale);
    update();
  }
}
