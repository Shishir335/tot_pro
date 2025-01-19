import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tot_pro/app/data/api_client.dart';
import 'package:tot_pro/app/data/core/values/app_url.dart';
import 'package:tot_pro/models/category.dart';

class JoinController extends GetxController {
  ApiClient apiClient = ApiClient();

  bool isLoading = false;

  changeIsLoading(bool value) {
    isLoading = value;
    update();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressFirstLine = TextEditingController();
  TextEditingController addressSecondLine = TextEditingController();
  TextEditingController addressThirdLine = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController details = TextEditingController();

  XFile? cv;

  /// Get Job History Details  done
  Future joinUs() async {
    changeIsLoading(true);

    dio.FormData formData = dio.FormData.fromMap({
      "name": name.text,
      "email": email.text,
      "phone": phone.text,
      "address_first_line": addressFirstLine.text,
      "address_second_line": addressSecondLine.text,
      "address_third_line": addressThirdLine.text,
      "town": town.text,
      "postcode": postcode.text,
      "category_ids[]":
          jsonEncode([for (var item in selectedCategories) item.id.toString()]),
      'cv': await dio.MultipartFile.fromFile(cv!.path,
          filename: cv!.path.split('/').last),
    });

    var response = await post(ApiURL.joinUs, data: formData, isMultipart: true);

    changeIsLoading(false);

    if (response != null) {
      log(response.toString());
      Get.snackbar('Success', 'Join request successful');
      resetControllers();
    }
  }

  resetControllers() {
    addressSecondLine.clear();
    addressFirstLine.clear();
    addressThirdLine.clear();
    name.clear();
    email.clear();
    phone.clear();
    town.clear();
    postcode.clear();
    details.clear();
  }

  List<Data> selectedCategories = [];

  changeSelectedCategory(List<Data> values) {
    selectedCategories = values;
    update();
  }

  // Current Active
  void selectImage(ImageSource source, String type) async {
    final picker = ImagePicker();

    await picker.pickImage(source: source).then((value) {
      if (value != null) {
        cv = value;
      }
    });
    update();

    Get.back();
  }
}

post(String endPoint, {dynamic data, bool isMultipart = false}) async {
  SharedPreferences? prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  log(token!);
  log(endPoint);
  log(data.toString());

  try {
    var res = await dio.Dio().post(endPoint,
        data: data,
        options: dio.Options(
            headers: isMultipart
                ? {
                    'Authorization': 'Bearer $token',
                    "Content-Type": "multipart/form-data",
                  }
                : {
                    'Authorization': 'Bearer $token',
                  }));

    debugPrint(res.data.toString());
    debugPrint(res.statusCode.toString());
  } on dio.DioException catch (e) {
    print(e);
  }
}
