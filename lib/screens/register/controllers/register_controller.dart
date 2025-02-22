import 'dart:convert';
import 'package:field_suggestion/box_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/snackbar.dart';
import 'package:tot_pro/models/menu_model.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import '../../../models/address_model.dart';
import '../../../utils/data/api_client.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../../../utils/routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement ContactController
  late ApiClient _apiClient;
  var formKey = GlobalKey<FormState>();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isShowPasswordConfirm = true.obs;

  TextEditingController nameCTL = TextEditingController();
  TextEditingController companyCTL = TextEditingController();
  TextEditingController mobileCTL = TextEditingController();
  TextEditingController mailCTL = TextEditingController();
  TextEditingController passwordCTL = TextEditingController();
  TextEditingController confirmPasswordCTL = TextEditingController();

  TextEditingController addressLineOneController = TextEditingController();
  TextEditingController firstCnt = TextEditingController();

  TextEditingController addressLineTwoController = TextEditingController();
  TextEditingController addressLineThreeController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();
  TextEditingController postcodeTextController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  final menuList = <MenuModel>[].obs;
  final count = 0.obs;

  ///------------ Address --------------
  ///
  static const String _baseUrl = 'https://api.ideal-postcodes.co.uk';
  //static const String _key = 'ak_lu3q2fx5XP10rIvksRD4uw1CHqKSM';
  static const String _key = 'ak_lt4ocv0eHLLo4meBRGHWK4HU0SBxa';

  var boxController = BoxController();
  bool shouldSearch = true;

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

      print('RegisterController.searchAddress ${response.body}');
      //    response = await _repository.searchAddress(query);

      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        for (var data in mapdata['result']['hits']) {
          addressList.add(AddressModel.fromJson(data));
        }
        print('address lng :: ${addressList.toString()}');
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
      //response = await _repository.getAddressDetails(endpoint);

      print(
          'RegisterController.getAndSetAddressDetails ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> mapdata = json.decode(response.body);
        firstCnt.text = mapdata['result']['line_1'] ?? '';
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
  void onInit() {
    _apiClient = ApiClient();
    super.onInit();
  }

  void increment() => count.value++;

  Future registerControllerBTN() async {
    if (passwordCTL.text != confirmPasswordCTL.text) {
      helloSnack('Alert', 'Password and confirm pasword has not match');
    } else {
      if (registerFormKey.currentState!.validate()) {
        final response = await _apiClient.connection(
          API_TYPE: 'res',
          apiType: 'POST',
          REQUEST_TYPE: '',
          REQUEST_DATA: {
            "name": nameCTL.text.toString(),
            "surname": companyCTL.text.toString(),
            "email": mailCTL.text.toString(),
            "phone": mobileCTL.text.toString(),
            "address_first_line": firstCnt.text.toString(),
            "address_second_line": addressLineTwoController.text.toString(),
            "address_third_line": addressLineThreeController.text.toString(),
            "postcode": postcodeTextController.text.toString(),
            "town": countryTextController.text.toString(),
            "password": passwordCTL.text.toString(),
            "password_confirmation": confirmPasswordCTL.text.toString(),
          },
          apiUrl: ApiURL.registerUrl,
          PARAM: {},
        );
        if (response != null) {
          final Map<String, dynamic> myresponse = response.data;
          int id = myresponse["userId"]['id'];
          String token = myresponse["token"];
          await localStoreSRF.setString('token', token.toString());
          await localStoreSRF.setString('id', id.toString());
          await localStoreSRF.setString('register', 'register');
          Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
        }
      }
    }
  }
}
