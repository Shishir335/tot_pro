import 'package:get/get.dart';
import 'package:tot_pro/utils/localization/localization_controller.dart';

import '../../../utils/routes/app_pages.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    Get.put(LocalizationController());

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(
        Routes.LOGIN,
      );
    });
       super.onInit();
  }

}
