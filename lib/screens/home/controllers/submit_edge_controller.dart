import 'dart:convert';
import 'dart:developer';
import 'package:field_suggestion/box_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tot_pro/models/about_us.dart';
import 'package:tot_pro/models/category.dart';
import 'package:tot_pro/utils/data/api_services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import '../../../main.dart';
import '../../../models/address_model.dart';
import '../../../models/user_profile_model.dart';
import '../../../utils/data/api_client.dart';
import '../../../utils/data/core/values/app_helper.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../../../utils/data/dbhelper.dart';

class SubmitEdgeController extends GetxController {
  final postCodeStatus = ''.obs;
  final postCodeStatusMsg = ''.obs;
  final searchPostCodeName = ''.obs;
  ApiService? apiService;
  final isUseRegisterAddress = false.obs;
  final isUseRegisterNumber = false.obs;
  File? imageFile;

  List<TextEditingController> descriptionCont = [];
  GlobalKey<FormState> submitFormKey = GlobalKey<FormState>();
  final descriptionCnt = TextEditingController();

  final imageFiles = <File>[].obs;
  TextEditingController nameCon = TextEditingController();
  TextEditingController mailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController houseCon = TextEditingController();
  TextEditingController townCon = TextEditingController();
  TextEditingController streetCon = TextEditingController();
  TextEditingController postCon = TextEditingController();
  TextEditingController commentCon = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;
  Rx<UserProfileModel> proInfo = UserProfileModel().obs;

  late ApiClient _apiClient;

  ///------------ Address --------------
  ///
  static const String _baseUrl = 'https://api.ideal-postcodes.co.uk';
  //static const String _key = 'ak_lu3q2fx5XP10rIvksRD4uw1CHqKSM';
  static const String _key = 'ak_lt4ocv0eHLLo4meBRGHWK4HU0SBxa';

  var boxController = BoxController();
  var addressLineOneController = TextEditingController();
  final firstAddress = ''.obs;
  var addressLineTwoController = TextEditingController();
  var addressLineThreeController = TextEditingController();
  var countryTextController = TextEditingController();
  var postcodeTextController = TextEditingController();
  bool shouldSearch = true;
  final isVideoCapture = false.obs;

  final fileModeCameraOrVideo = 'camera'.obs;

  returnEmptyFutureData() =>
      Future.delayed(Duration.zero).then((value) => <AddressModel>[]);

  Future<List<AddressModel>> searchAddress(query) async {
    List<AddressModel> addressList = [];

    try {
      var headers = {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      http.Response response = await http.get(
        Uri.parse(
            '$_baseUrl/v1/autocomplete/addresses?api_key=$_key&&query=$query'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        for (var data in mapdata['result']['hits']) {
          addressList.add(AddressModel.fromJson(data));
        }
        return addressList;
      } else {
        return addressList;
      }
    } catch (ex) {
      return addressList;
    }
  }

  Future getAndSetAddressDetails(endpoint) async {
    try {
      var url = '$_baseUrl$endpoint?api_key=$_key';
      var headers = {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        addressLineTwoController.text = mapdata['result']['line_2'] ?? '';
        addressLineThreeController.text = mapdata['result']['line_3'] ?? '';
        countryTextController.text = mapdata['result']['post_town'] ?? '';
        postcodeTextController.text = mapdata['result']['postcode'] ?? '';
      } else {
        clearController();
      }
    } catch (ex) {
      clearController();
    }
  }

  clearController() {
    addressLineOneController.clear();
    addressLineTwoController.clear();
    addressLineThreeController.clear();
    countryTextController.clear();
    postcodeTextController.clear();
  }

  @override
  void onInit() async {
    submitFormKey = GlobalKey<FormState>();
    apiService = ApiService();
    _apiClient = ApiClient();
    getDetailsInfo();
    getAboutUs();
    super.onInit();
  }

  AboutUs? aboutUs;

  Future getAboutUs() async {
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.aboutUs,
      PARAM: {},
    );

    if (response != null) {
      aboutUs = AboutUs.fromJson(response.data);
      update();
    }
  }

  void increment() => count.value++;

  // Current Active
  void selectImage(ImageSource source, String type) async {
    fileModeCameraOrVideo.value = type;
    debugPrint('source :: $source');
    debugPrint('type :: $type');
    if (imageFiles.length <= 3) {
      final picker = ImagePicker();
      final XFile? pickedFile;
      if (type == 'video') {
        pickedFile = await picker.pickVideo(source: source);
      } else {
        pickedFile = await picker.pickImage(source: source);
      }

      Get.back();

      if (pickedFile != null) {
        var descriptionCnt = TextEditingController();

        imageFile = File(pickedFile.path);
        imageFiles.add(File(pickedFile.path));
        descriptionCont.add(descriptionCnt);
        isVideoCapture.value = false;
      }
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert'.tr, bodyText: 'Maximum Three Images'.tr);
    }
  }

  void selectVideo(ImageSource source) async {
    debugPrint('source :: $source');
    if (imageFiles.length <= 3) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(source: source);
      Get.back();
      imageFile = File(pickedFile!.path);
      imageFiles.add(
        File(pickedFile.path),
      );
      descriptionCont.add(descriptionCnt);
      isVideoCapture.value = true;
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Alert'.tr,
          bodyText: 'You cannot upload more then four files.'.tr);
    }
  }

  /// PostCode Check done
  Future postCodeCheck(String postCode) async {
    final response = await ApiService().connectionImage(
      API_TYPE: 'POST',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: {"postcode": postCode},
      apiUrl: 'https://www.edgeemg.co.uk/api/check-post-code',
      PARAM: {},
    );

    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      if (mapdata['status'] == 303) {
        postCodeStatusMsg.value = mapdata['message'];
      } else {
        postCodeStatusMsg.value = mapdata['message'];
        postCodeStatus.value = mapdata['data']['status'];
        searchPostCodeName.value = mapdata['data']['postcode'];
      }
    }
  }

  List<Data> selectedCategories = [];

  changeSelectedCategory(List<Data> data) {
    if (data.length == 2) {
      Data category = data[1];
      selectedCategories.clear();
      selectedCategories.add(category);
    } else {
      selectedCategories.add(data[0]);
    }
    update();
  }

  /// Work Submit  done Image
  Future<void> workSubmit(BuildContext context) async {
    final Directory tempDir = await getTemporaryDirectory();
    DBHelper.loadingDialog(Get.overlayContext!);
    List<http.MultipartFile> multipartFileList = [];
    loading.value = true;
    String? token = localStoreSRF.getString('token');
    Map<String, String> customHeader = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final url = Uri.parse(
        "https://www.totpro.net/api/work-store/${selectedCategories[0].id}");

    log("https://www.totpro.net/api/work-store/${selectedCategories[0].id}");

    var request = http.MultipartRequest('POST', url);

    if (imageFiles.isNotEmpty) {
      for (int i = 0; i < imageFiles.length; i++) {
        String extendFile = imageFiles[i].path.split('.').last;

        if (extendFile.toLowerCase() == 'jpg' ||
            extendFile == 'png' ||
            extendFile == 'bmp' ||
            extendFile == 'webp' ||
            extendFile == 'heic' ||
            extendFile == 'jpge') {
          final targetPath = '${tempDir.absolute.path}/temp.jpg';
          final compressImage = await FlutterImageCompress.compressAndGetFile(
              imageFiles[i].path, targetPath,
              minHeight: 1000, minWidth: 1000, quality: 90);
          multipartFileList.add(
            http.MultipartFile(
                'images[]',
                File(compressImage!.path).readAsBytes().asStream(),
                File(compressImage.path).lengthSync(),
                filename: targetPath),
          );
        } else {
          multipartFileList.add(http.MultipartFile(
              'images[]',
              File(imageFiles[i].path).readAsBytes().asStream(),
              File(imageFiles[i].path).lengthSync(),
              filename: imageFiles[i].path));
        }

        request.fields['descriptions[$i]'] = descriptionCont[i].text == ''
            ? 'no description'
            : descriptionCont[i].text;
      }
      request.files.addAll(multipartFileList);
    }

    Map<String, String> workSubmitMap = {
      "name": nameCon.text.toString(),
      "email": mailCon.text.toString(),
      "address_first_line": firstAddress.value == ''
          ? addressLineOneController.text.toString()
          : firstAddress.value,
      "address_second_line": addressLineTwoController.text.toString(),
      "address_third_line": addressLineThreeController.text.toString(),
      "phone": phoneCon.text.toString(),
      "town": countryTextController.text.toString(),
      "post_code": postcodeTextController.text,

      // 'descriptions[]': 'This is first description u13@gmail.com',
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

      if (response.statusCode == 200) {
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
                    Text('Work Order is added successfully!'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green)),
                    Image.asset('assets/images/successful.png'),
                    AppSpace.spaceH10,
                    ElevatedButton(
                        onPressed: () {
                          phoneCon.clear();
                          streetCon.clear();
                          townCon.clear();
                          postCon.clear();
                          houseCon.clear();
                          countryTextController.clear();
                          commentCon.clear();
                          addressLineThreeController.clear();
                          addressLineOneController.clear();
                          addressLineTwoController.clear();
                          descriptionCont.clear();
                          postcodeTextController.clear();
                          postCodeStatusMsg.value = '';
                          postCodeStatus.value = '';
                          imageFiles.clear();
                          isUseRegisterAddress.value = false;
                          isUseRegisterNumber.value = false;
                          isVideoCapture.value = false;
                          DBHelper.loadingClose();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(150, 40)),
                        child: const Text('Ok')),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      } else if (response.statusCode.toString() == '302') {
        DBHelper.loadingClose();
        loading.value = false;
      } else {
        // pDialog.hide();
        loading.value = false;
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
    loading.value = false;
  }

  /// Work Submit  done Video
  Future<void> workSubmitVideo(BuildContext context) async {
    final Directory tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.absolute.path}/temp.mp4';

    DBHelper.loadingDialog(Get.overlayContext!);
    List<http.MultipartFile> multipartFileList = [];
    loading.value = true;

    String? token = localStoreSRF.getString('token');

    Map<String, String> customHeader = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final url = Uri.parse("https://www.totpro.net/api/work");

    log("https://www.totpro.net/api/work");

    var request = http.MultipartRequest('POST', url);

    if (imageFiles.isNotEmpty) {
      for (int i = 0; i < imageFiles.length; i++) {
        request.fields['descriptions[$i]'] = descriptionCont[i].text;
        multipartFileList.add(http.MultipartFile(
            'images[]',
            File(imageFiles[i].path).readAsBytes().asStream(),
            File(imageFiles[i].path).lengthSync(),
            filename: targetPath));
      }

      request.files.addAll(multipartFileList);
    }
    // else {
    //   Helpers.snackbarForErorr(
    //       titleText: 'Alert Message'.tr, bodyText: 'Image field required.'.tr);
    // }

    Map<String, String> workSubmitMap = {
      "name": nameCon.text.toString(),
      "email": mailCon.text.toString(),
      "address_first_line": firstAddress.value == ''
          ? addressLineOneController.text.toString()
          : firstAddress.value,
      "address_second_line": addressLineTwoController.text.toString(),
      "address_third_line": addressLineThreeController.text.toString(),
      "phone": phoneCon.text.toString(),
      "town": countryTextController.text.toString(),
      "post_code": postcodeTextController.text,
    };

    print(workSubmitMap);

    request.fields.addAll(workSubmitMap);
    request.headers.addAll(customHeader);

    try {
      var response = await request.send();
      var responseStream = await response.stream.bytesToString();

      debugPrint(' status code : ${response.statusCode}');
      debugPrint('responseStream  : $responseStream');

      if (response.statusCode == 200) {
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 390,
                padding: const EdgeInsets.all(16.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Work Order is added successfully!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                  Image.asset('assets/images/successful.png'),
                  AppSpace.spaceH10,
                  InkWell(
                      onTap: () {
                        phoneCon.clear();
                        streetCon.clear();
                        townCon.clear();
                        postCon.clear();
                        houseCon.clear();
                        countryTextController.clear();
                        commentCon.clear();
                        addressLineThreeController.clear();
                        addressLineOneController.clear();
                        addressLineTwoController.clear();
                        descriptionCont.clear();
                        postcodeTextController.clear();
                        postCodeStatusMsg.value = '';
                        postCodeStatus.value = '';
                        imageFiles.clear();
                        isUseRegisterAddress.value = false;
                        isUseRegisterNumber.value = false;
                        isVideoCapture.value = false;
                        DBHelper.loadingClose();
                        Get.back();
                      },
                      child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("OK".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white))))),
                  const SizedBox(height: 10)
                ]),
              ),
            );
          },
        );
      } else if (response.statusCode.toString() == '302') {
        DBHelper.loadingClose();
        loading.value = false;
      } else {
        loading.value = false;
        DBHelper.loadingClose();
        Get.snackbar(
          'Error',
          'Status code :  ${response.statusCode.toString()}\n work order has Failed ',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      DBHelper.loadingClose();
      Get.snackbar(
        'Failed'.tr,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error occurred: $e');
    }
    loading.value = false;
    // pDialog.hide();
  }

  /// done
  Future getDetailsInfo() async {
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.userDetailsUrl,
      PARAM: {},
    );

    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      var info = mapdata['response']['data'];
      proInfo.value = UserProfileModel.fromJson(info);

      nameCon.text = proInfo.value.name ?? '';
      mailCon.text = proInfo.value.email ?? '';

      update();
    }
  }
}
