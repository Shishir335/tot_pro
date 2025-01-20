import 'package:get/get.dart';

import '../controllers/payment_transaction_controller.dart';

class PaymentTransactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentTransactionController>(
      () => PaymentTransactionController(),
    );
  }
}
