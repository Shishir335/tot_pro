import 'package:shared_preferences/shared_preferences.dart';
import 'package:tot_pro/utils/data/snackbar.dart';
import '../../../main.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsController extends GetxController {
  final changePasswordFormKey = GlobalKey<FormState>();

  bool isFaceId = false;

  final count = 0.obs;

  @override
  void onInit() {
    isFaceId = localStoreSRF.getBool('isFaceId') ?? false;
    setLanguage();
    super.onInit();
  }

  changeFaceIdUse(bool value) async {
    if (value == true) {
      isFaceId = true;
      await localStoreSRF.setBool('isFaceId', true);
      successSnack('Face Id has Added');
    } else {
      isFaceId = false;
      await localStoreSRF.setBool('isFaceId', false);
      successSnack('Face Id has not Added');
    }
    update();
  }

  void increment() => count.value++;

  // Language settings
  String language = 'en';

  // @override
  // void onInit() {
  //   changeLanguage(language);
  //   super.onInit();
  // }

  setLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language') == null ||
        prefs.getString('language') == 'en') {
      changeLanguage('en');
    } else {
      changeLanguage('ro');
    }
  }

  void changeLanguage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', value);
    language = value;
    Locale locale =
        language == 'en' ? const Locale('en', 'US') : const Locale('ro', 'RO');
    Get.updateLocale(locale);
    EasyLocalization.of(Get.context!)!.setLocale(locale);
    update();
  }
}
