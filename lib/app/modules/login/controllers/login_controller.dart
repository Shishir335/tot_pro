import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_url.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement ContactController

  Rx<bool> isLoginShowPassword = true.obs;
  final loginFormKey = GlobalKey<FormState>();
  late ApiClient _apiClient;
  TextEditingController mailCTL = TextEditingController();
  TextEditingController passwordCTL = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    _apiClient = ApiClient();
    super.onInit();
  }

  void increment() => count.value++;

  Future loginController() async {
    final response = await _apiClient.connectionLogin(
      API_TYPE: 'LOGIN',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: {"email": mailCTL.text, "password": passwordCTL.text},
      apiUrl: ApiURL.loginUrl,
      PARAM: {},
    );
    if (response != null) {
      final Map<String, dynamic> myresponse = response.data;

      print('LoginController.loginController myresponse >>> $myresponse');
      int id = myresponse["userId"];
      String token = myresponse["token"];
      //print('token ::$token');
      print('id ::$id');
      await localStoreSRF.setString('token', token.toString());
      await localStoreSRF.setString('id', id.toString());
      Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
    }
  }
}
