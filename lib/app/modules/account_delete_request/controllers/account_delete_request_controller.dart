import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';

import '../../../../main.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_url.dart';
import '../../../routes/app_pages.dart';

class AccountDeleteRequestController extends GetxController {
  //TODO: Implement ContactController

  final changePasswordFormKey = GlobalKey<FormState>();

  Rx<bool> isShowOldPassword = true.obs;
  Rx<bool> isShowNewPassword = true.obs;
  Rx<bool> isShowConfirmPassword = true.obs;

  TextEditingController oldPasswordCTL = TextEditingController();
  TextEditingController newPasswordCTL = TextEditingController();
  TextEditingController confirmPasswordCTL = TextEditingController();

  final menuList = <MenuModel>[].obs;
  final count = 0.obs;
  late ApiClient _apiClient;
  @override
  void onInit() {
    _apiClient = ApiClient();
    super.onInit();
  }

  void increment() => count.value++;

  Future changePasswordController() async {
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'LOGIN',
      apiType: 'PUT',
      REQUEST_TYPE: '',
      REQUEST_DATA: {
        "current_password": oldPasswordCTL.text,
        "new_password": newPasswordCTL.text,
        "new_password_confirmation": confirmPasswordCTL.text
      },
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.changePasswordUrl,
      PARAM: {},
    );
    if (response != null) {
      final Map<String, dynamic> myresponse = response.data;

      Helpers.snackbarForSucess(
          titleText: 'Successful Alert',
          bodyText: 'Change Password has successful!');
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
    }
  }
}
