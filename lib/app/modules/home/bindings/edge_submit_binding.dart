import 'package:get/get.dart';

import '../controllers/submit_edge_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitEdgeController>(
      () => SubmitEdgeController(),
    );
  }
}
