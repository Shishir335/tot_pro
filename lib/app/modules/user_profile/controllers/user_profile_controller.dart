import 'dart:convert';

import 'package:field_suggestion/box_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tot_pro/models/user_profile_model.dart';

import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../../models/address_model.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_url.dart';

class UserProfileController extends GetxController {
  //TODO: Implement ContactController
  DashboardController dashboardCTN = Get.find();
  RxBool isReadOnly = true.obs;
  final userProfileFormKey = GlobalKey<FormState>();
  TextEditingController nameCTL = TextEditingController();
  TextEditingController companyCTL = TextEditingController();
  TextEditingController mobileCTL = TextEditingController();
  TextEditingController addressFirstLineCTL = TextEditingController();
  TextEditingController addressSecondLineCTL = TextEditingController();
  TextEditingController addressThirdLineCTL = TextEditingController();
  TextEditingController townCTL = TextEditingController();
  TextEditingController postCodeCTL = TextEditingController();
  TextEditingController mailCTL = TextEditingController();
  TextEditingController passwordCTL = TextEditingController();
  TextEditingController confirmPasswordCTL = TextEditingController();

  var name = '';
  final firstAddress = ''.obs;

  Rx<UserProfileModel> proInfo = UserProfileModel().obs;
  late ApiClient _apiClient;

  final count = 0.obs;
  @override
  void onInit() async {
    _apiClient = ApiClient();
    await getDetailsInfo();

    print('pr :${proInfo.value.name}');
    print('address  first :${proInfo.value.addressFirstLine}');
    firstAddress.value = proInfo.value.addressFirstLine.toString();
    print('address  first :${proInfo.value.toJson()}');

    addressFirstLineCTL.text = proInfo.value.addressFirstLine.toString();
    // firstAddress=proInfo.value.addressFirstLine??'no data';
    print('UserProfileController.onInit >>$firstAddress');

    super.onInit();
  }

  ///------------ Address --------------
  ///
  static const String _baseUrl = 'https://api.ideal-postcodes.co.uk';
  //static const String _key = 'ak_lu3q2fx5XP10rIvksRD4uw1CHqKSM';
  static const String _key = 'ak_lt4ocv0eHLLo4meBRGHWK4HU0SBxa';

  var boxController = BoxController();
  var dummyController = TextEditingController();
  var addressLineOneController = TextEditingController();
  var addressLineTwoController = TextEditingController();
  var addressLineThreeController = TextEditingController();
  //  var countryTextController = TextEditingController();
  //  var postcodeTextController = TextEditingController();
  bool shouldSearch = true;

  returnEmptyFutureData() =>
      Future.delayed(Duration.zero).then((value) => <AddressModel>[]);

  Future<List<AddressModel>> searchAddress(query) async {
    print('query :$query');
    dynamic response;
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
    dynamic response;

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
        // addressLineOneController.text = mapdata['result']['line_1'] ?? '';
        dummyController.text = mapdata['result']['line_1'] ?? '';
        //print(' first Line :: ${addressFirstLine}');
        addressLineTwoController.text = mapdata['result']['line_2'] ?? '';
        addressLineThreeController.text = mapdata['result']['line_3'] ?? '';
        townCTL.text = mapdata['result']['post_town'] ?? '';
        postCodeCTL.text = mapdata['result']['postcode'] ?? '';
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
    townCTL.clear();
    postCodeCTL.clear();
    // dummyController.clear();
  }

  fetchUserInfo() {
    proInfo.value = dashboardCTN.userProfile.value;

    print('name :: ');
    nameCTL.value == proInfo.value.name;
    var company =
        proInfo.value.surname.toString() == 'null' ? '' : proInfo.value.surname;
    var secondLine = proInfo.value.addressSecondLine.toString() == 'null'
        ? ''
        : proInfo.value.addressSecondLine;
    var thirdLine = proInfo.value.addressThirdLine.toString() == 'null'
        ? ''
        : proInfo.value.addressThirdLine;
    companyCTL.text == company.toString();

    mobileCTL.value.text == proInfo.value.photo;
    mailCTL.text == proInfo.value.email;
    postCodeCTL.text == proInfo.value.postcode;
    addressFirstLineCTL.text == proInfo.value.addressFirstLine;
    print('UserProfileController.fetchUserInfo ${addressFirstLineCTL.text}');
    townCTL.text == proInfo.value.town;
  }

  void increment() => count.value++;

  /// Update Profile

  Future updateProfileUpdate() async {
    var Name =
        nameCTL.value.text == '' ? proInfo.value.name : nameCTL.value.text;
    var company = companyCTL.value.text == ''
        ? proInfo.value.phone
        : companyCTL.value.text;
    var phone =
        mobileCTL.value.text == '' ? proInfo.value.phone : mobileCTL.value.text;
    var mail =
        mailCTL.value.text == '' ? proInfo.value.phone : mailCTL.value.text;
    var addressFirst = addressFirstLineCTL.value.text == ''
        ? proInfo.value.addressFirstLine
        : addressFirstLineCTL.value.text;
    var addressSecond = addressSecondLineCTL.value.text == ''
        ? proInfo.value.addressSecondLine
        : addressSecondLineCTL.value.text;
    var addressThird = addressThirdLineCTL.value.text == ''
        ? proInfo.value.addressThirdLine
        : addressThirdLineCTL.value.text;
    var town =
        townCTL.value.text == '' ? proInfo.value.town : townCTL.value.text;
    var postCode = postCodeCTL.value.text == ''
        ? proInfo.value.postcode
        : postCodeCTL.value.text;

    Map<String, dynamic> profileMap = {
      "name": Name,
      "surname": company,
      "email": mail,
      "phone": phone,
      "address_first_line": addressFirst,
      "address_second_line": addressSecond,
      "address_third_line": addressThird,
      "town": town,
      "postcode": postCode,
    };

    print('MyProfileController.getUserProfileInfo');
    String? token = localStoreSRF.getString('token');

    final response = await _apiClient.connectionNew(
      API_TYPE: 'POST',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: profileMap,
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.updateProfileUrl,
      PARAM: {},
    );

    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      Helpers.snackbarForSucess(
          titleText: 'Successful Alert',
          bodyText: 'Profile update has successful!');
      await getDetailsInfo();
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Error Alert',
          bodyText: 'Profile update has Wrong.\n please try again');
    }
  }

  /// done
  Future getDetailsInfo() async {
    print('DashboardController.getUserDetailsCTR');
    // String? token = await localStoreSRF.getString('token');
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
      print('UserProfileController.getDetailsInfo');
      final Map<String, dynamic> mapdata = response.data;
      var info = mapdata['response']['data'];
      proInfo.value = UserProfileModel.fromJson(info);

      print('user Info :: ${proInfo.value.toJson()}');
      nameCTL.text = proInfo.value.name.toString();
      companyCTL.text = proInfo.value.surname ?? '';
      mailCTL.text = proInfo.value.email.toString();
      mobileCTL.text = proInfo.value.phone.toString();
      postCodeCTL.text = proInfo.value.postcode ?? '';
      townCTL.text = proInfo.value.town ?? '';
      addressFirstLineCTL.text = proInfo.value.addressFirstLine ?? '';

      print('addressFirstLineCTL ${addressFirstLineCTL.text}');
      addressSecondLineCTL.text = proInfo.value.addressSecondLine ?? '';

      addressThirdLineCTL.text = proInfo.value.addressThirdLine ?? '';
    }
  }
}
