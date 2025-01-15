import 'package:get/get.dart';

import '../controllers/join_controller.dart';

class JoinUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinController>(() => JoinController());
  }
}
