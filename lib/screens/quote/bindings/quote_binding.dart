import 'package:get/get.dart';

import '../controllers/quote_controller.dart';

class QuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteController>(() => QuoteController());
  }
}
