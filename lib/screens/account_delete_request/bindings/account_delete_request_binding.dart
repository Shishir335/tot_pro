import 'package:get/get.dart';

import '../controllers/account_delete_request_controller.dart';

class AccountDeleteRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountDeleteRequestController>(
      () => AccountDeleteRequestController(),
    );
  }
}
