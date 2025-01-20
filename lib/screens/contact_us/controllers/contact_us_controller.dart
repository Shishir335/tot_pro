import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/api_client.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/main.dart';

class ContactUsController extends GetxController {
  ApiClient apiClient = ApiClient();

  bool isLoading = false;

  changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  /// Get Job History Details  done
  Future contactUs() async {
    changeIsLoading(true);
    String? token = localStoreSRF.getString('token');
    final response = await apiClient.connection(
      API_TYPE: 'POST',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: {
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "message": message.text,
      },
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.contactUs,
      PARAM: {},
    );

    changeIsLoading(false);

    if (response != null) {
      log(response.data.toString());
    }
  }
}
