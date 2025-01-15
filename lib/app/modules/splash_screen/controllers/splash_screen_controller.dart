import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(
        Routes.LOGIN,
      );
    });
       super.onInit();
  }

}
