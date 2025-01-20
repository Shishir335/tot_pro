import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
  }
}
