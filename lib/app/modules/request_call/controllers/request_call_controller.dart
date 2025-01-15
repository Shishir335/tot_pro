import 'package:get/get.dart';

import '../../../data/api_client.dart';

class RequestCallController extends GetxController {
  //TODO: Implement ContactController
  late ApiClient _apiClient;
  final count = 0.obs;
  @override
  void onInit() {
    _apiClient = ApiClient();
    super.onInit();
  }

  void increment() => count.value++;
}
