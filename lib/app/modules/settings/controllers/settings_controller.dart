import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';
import '../../../../main.dart';
import '../../../data/api_client.dart';

class SettingsController extends GetxController {
  //TODO: Implement ContactController

  final changePasswordFormKey = GlobalKey<FormState>();

  final isFaceId = false.obs;

  final menuList = <MenuModel>[].obs;
  final count = 0.obs;
  late ApiClient _apiClient;
  @override
  void onInit() {
    isFaceId.value = localStoreSRF.getBool('isFaceId') ?? false;
    _apiClient = ApiClient();
    super.onInit();
  }

  void increment() => count.value++;
}
