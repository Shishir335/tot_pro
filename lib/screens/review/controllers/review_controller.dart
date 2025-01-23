import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/api_client.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/main.dart';

class ReviewController extends GetxController {
  ApiClient apiClient = ApiClient();

  bool isLoading = false;

  changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController review = TextEditingController();

  int stars = 5;

  changeStar(int value) {
    stars = value + 1;
    update();
  }

  /// Get Job History Details  done
  Future submitReview() async {
    changeIsLoading(true);
    String? token = localStoreSRF.getString('token');
    final response = await apiClient.connection(
      API_TYPE: 'POST',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: {
        "name": name.text,
        "email": email.text,
        "phone": phone.text,
        "stars": stars.toString(),
        "review": review.text,
      },
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.review,
      PARAM: {},
    );

    changeIsLoading(false);

    if (response != null) {
      log(response.data.toString());
      Get.snackbar('Success'.tr, 'Review submit successful'.tr);
      resetControllers();
    }
  }

  resetControllers() {
    name.clear();
    email.clear();
    phone.clear();
    review.clear();
    update();
  }

  @override
  void onInit() {
    resetControllers();
    super.onInit();
  }
}
