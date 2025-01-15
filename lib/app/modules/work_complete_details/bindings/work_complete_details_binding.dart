import 'package:get/get.dart';

import '../controllers/work_complete_details_controller.dart';

class WorkCompleteDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkCompleteDetailsController>(
      () => WorkCompleteDetailsController(),
    );
  }
}
