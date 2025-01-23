import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tot_pro/main.dart';
import 'package:tot_pro/utils/data/api_client.dart';
import 'package:tot_pro/utils/data/core/values/app_helper.dart';
import 'package:tot_pro/utils/data/core/values/app_space.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/models/category.dart';
import 'package:tot_pro/utils/data/dbhelper.dart';
import "package:http/http.dart" as http;

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

  void pickFile() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    ).then((value) {
      cv = value!.files[0].xFile;
      update();
    });
  }

  /// Work Submit  done Image
  Future<void> joinUs(BuildContext context) async {
    print('SubmitEdgeController.workSubmit Image Upload ');
    final Directory tempDir = await getTemporaryDirectory();
    if (cv != null) {
      DBHelper.loadingDialog(Get.overlayContext!);
      List<http.MultipartFile> multipartFileList = [];
      changeIsLoading(true);
      String? token = localStoreSRF.getString('token');
      Map<String, String> customHeader = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      final url = Uri.parse(ApiURL.joinUs);
      var request = http.MultipartRequest('POST', url);

      String extendFile = cv!.path.split('.').last;
      print('SubmitEdgeController extendFile >>$extendFile');

      if (extendFile.toLowerCase() == 'jpg' ||
          extendFile == 'png' ||
          extendFile == 'bmp' ||
          extendFile == 'webp' ||
          extendFile == 'heic' ||
          extendFile == 'jpge') {
        final targetPath = '${tempDir.absolute.path}/temp.jpg';
        final compressImage = await FlutterImageCompress.compressAndGetFile(
            cv!.path, targetPath,
            minHeight: 1000, minWidth: 1000, quality: 90);
        final bytes1 = compressImage!.readAsBytes().toString();
        final newKb = bytes1.length / 2024;
        final newMb = newKb / 2024;
        debugPrint('Compress Image Size newKb : ${newKb.toString()}');
        debugPrint('Compress Image Size newMb: ${newMb.toString()}');
        // var length = await compressImage.length();
        // var stream = http.ByteStream(compressImage.openRead());
        multipartFileList.add(
          http.MultipartFile(
              'cv',
              File(compressImage.path).readAsBytes().asStream(),
              File(compressImage.path).lengthSync(),
              filename: targetPath),
        );

        print('Camera & Gallery');
      } else {
        print('Video Option ');
        multipartFileList.add(
          http.MultipartFile('cv', File(cv!.path).readAsBytes().asStream(),
              File(cv!.path).lengthSync(),
              filename: cv!.path),
        );
      }

      // request.fields['descriptions[$i]'] = descriptionCont[i].text == ''
      //     ? 'no description'
      //     : descriptionCont[i].text;

      print('multipartFileList final tesing  :: ${multipartFileList.length}');

      request.files.addAll(multipartFileList);

      Map<String, String> workSubmitMap = {
        "name": name.text,
        "email": email.text,
        "phone": phone.text,
        "address_first_line": addressFirstLine.text,
        "address_second_line": addressSecondLine.text,
        "address_third_line": addressThirdLine.text,
        "town": town.text,
        "postcode": postcode.text,
        for (var item in selectedCategories)
          "category_ids[]": item.id.toString(),
      };

      print(workSubmitMap);
      request.fields.addAll(workSubmitMap);
      request.headers.addAll(customHeader);

      try {
        var response = await request.send();
        var responseStream = await response.stream.bytesToString();
        //  pDialog.hide();

        debugPrint(' status code : ${response.statusCode}');
        debugPrint('responseStream  : $responseStream');

        if (response.statusCode == 201) {
          // pDialog.hide();
          return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  width: 390,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('You have joined successfully!'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      Image.asset('assets/images/successful.png'),
                      AppSpace.spaceH10,
                      ElevatedButton(
                          onPressed: () {
                            addressSecondLine.clear();
                            addressFirstLine.clear();
                            addressThirdLine.clear();
                            name.clear();
                            email.clear();
                            phone.clear();
                            town.clear();
                            postcode.clear();
                            details.clear();
                            selectedCategories.clear();
                            cv = null;
                            DBHelper.loadingClose();
                            changeIsLoading(false);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: const Size(150, 40)),
                          child: Text('Ok'.tr)),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (response.statusCode.toString() == '302') {
          //  pDialog.hide();
          print('SubmitEdgeController.workSubmit 302');
          DBHelper.loadingClose();
          changeIsLoading(false);
        } else {
          // pDialog.hide();
          changeIsLoading(false);
          DBHelper.loadingClose();
          Get.snackbar(
            'Error'.tr,
            'Status code :  ${response.statusCode.toString()}\n work order has Failed ',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        DBHelper.loadingClose();
        //  pDialog.hide();
        Get.snackbar(
          'Failed'.tr,
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error occurred: $e');
      }
      changeIsLoading(false);

      // pDialog.hide();
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert Message'.tr, bodyText: 'Image field required.'.tr);
    }
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
