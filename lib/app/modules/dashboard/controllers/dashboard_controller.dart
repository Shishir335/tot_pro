import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';

import '../../../../main.dart';
import '../../../../models/user_profile_model.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_url.dart';

class DashboardController extends GetxController {
  //TODO: Implement ContactController

  late ApiClient _apiClient;
  final menuList = <MenuModel>[].obs;
  Rx<UserProfileModel> userProfile = UserProfileModel().obs;

  final count = 0.obs;
  final checkAccountFlag = false.obs;
  final checkAccountMessage = ''.obs;

  @override
  void onInit() {
    menuList.add(MenuModel(
        menuId: 1,
        menuTitle: 'Submit an EDGE',
        icon: Icon(Icons.add_a_photo, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 2,
        menuTitle: 'Job History',
        icon: Icon(Icons.history, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 3,
        menuTitle: 'Request a call back',
        icon: Icon(Icons.call_outlined, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 4,
        menuTitle: 'Payment & Transactions',
        icon: Icon(Icons.payments_outlined,
            size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 5,
        menuTitle: 'Categories',
        icon: Icon(Icons.category, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 6,
        menuTitle: 'Request a Quote',
        icon: Icon(Icons.note, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 7,
        menuTitle: 'Leave a Review',
        icon: Icon(Icons.reviews, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 8,
        menuTitle: 'Join Us',
        icon: Icon(Icons.person_add, size: 40, color: Colors.red.shade900)));
    menuList.add(MenuModel(
        menuId: 9,
        menuTitle: 'Contact Us',
        icon: Icon(Icons.phone, size: 40, color: Colors.red.shade900)));

    _apiClient = ApiClient();
    // getUserDetailsCTR();
    checkAccount();
    super.onInit();
  }

  void increment() => count.value++;

  /// Get Job History Details just testing need

  /// Get Job History done done
  Future checkAccount() async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>>>>>>>');
    // String? token = await localStoreSRF.getString('token');
    String? token = localStoreSRF.getString('token');
    String? id = localStoreSRF.getString('id');
    final response = await _apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.accountDeleteThenLogoutUrl + id!,
      PARAM: {},
    );

    print('DashboardController.checkAccount >>');
    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      print('DashboardController.checkAccount $mapdata');
      // String status=mapdata['status'];
      String message = mapdata['message'];
      checkAccountMessage.value = message.toString();
      checkAccountFlag.value = true;
      //await localStoreSRF.setString('id', '');
      print('DashboardController.checkAccount $mapdata');
    } else {}
  }
}
