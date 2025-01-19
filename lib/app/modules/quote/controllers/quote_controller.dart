import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/api_client.dart';
import 'package:tot_pro/app/data/core/values/app_url.dart';
import 'package:tot_pro/main.dart';

class QuoteController extends GetxController {
  ApiClient apiClient = ApiClient();

  bool isLoading = false;

  changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController details = TextEditingController();

  /// Get Job History Details  done
  Future requestQuote() async {
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
        "city": city.text,
        "address": address.text,
        "details": details.text,
      },
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.quote,
      PARAM: {},
    );

    changeIsLoading(false);
    print('=============> ${response != null}');
    print('=============> $response');

    if (response != null) {
      log(response.data.toString());
      Get.snackbar('Success', 'Quote request successful');
      resetControllers();
    }
  }

  resetControllers() {
    name.clear();
    email.clear();
    phone.clear();
    city.clear();
    address.clear();
    details.clear();
    update();
  }

  @override
  void onInit() {
    resetControllers();
    super.onInit();
  }
}
