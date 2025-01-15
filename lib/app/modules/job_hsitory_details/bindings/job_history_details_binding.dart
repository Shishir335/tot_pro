import 'package:get/get.dart';

import '../controllers/job_history_details_controller.dart';

class JobHistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobHistoryDetailsController>(
      () => JobHistoryDetailsController(),
    );
  }
}
