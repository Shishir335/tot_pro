import 'package:get/get.dart';

import '../controllers/request_call_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestCallController>(
      () => RequestCallController(),
    );
  }
}
