import 'package:get/get.dart';

class RequestCallController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
