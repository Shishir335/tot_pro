import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/api_client.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/main.dart';
import 'package:tot_pro/models/category.dart';

class CategoryController extends GetxController {
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

  List<Data> categories = [];

  CategoryResponse? categoryResponse;

  /// Get Job History Details  done
  Future getCategories() async {
    changeIsLoading(true);
    String? token = localStoreSRF.getString('token');
    final response = await apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.category,
      PARAM: {},
    );

    changeIsLoading(false);

    if (response != null) {
      categoryResponse = CategoryResponse.fromJson(response.data);
      categories = categoryResponse!.response!.data!;
      update();
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
    getCategories();
    resetControllers();
    super.onInit();
  }
}
