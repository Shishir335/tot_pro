import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tot_pro/app/data/core/values/app_space.dart';
export 'package:get/get.dart';
import '../../../../main.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_assets.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_url.dart';
import '../controllers/request_call_controller.dart';

class RequestCallView extends GetView<RequestCallController> {
  const RequestCallView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Request a call back',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/request-callback.png"),
          AppSpace.spaceH20,
          InkWell(
            onTap: () async {
              late ApiClient apiClient = ApiClient();
              String? token = localStoreSRF.getString('token');
              final response = await apiClient.connection(
                API_TYPE: '',
                apiType: 'POST',
                REQUEST_TYPE: '',
                REQUEST_DATA: {},
                customheader: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token'
                },
                apiUrl: ApiURL.requestCallUrl,
                PARAM: {},
              );

              if (response != null) {
                Helpers.snackbarForSucess(
                    titleText: 'Successful Alert',
                    bodyText:
                        'We have received your request. We will callback very soon.');
              } else {
                Helpers.snackbarForErorr(
                    titleText: ' Error Alert',
                    bodyText: 'Urgent Request has Field');
              }
            },
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.all(20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "Request a call".toUpperCase(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )),
            ),
          ),
          AppSpace.spaceH20,
          Image.asset(
            AppAssets.appLogo,
            height: 200,
            width: 200,
          ),
        ],
      ),
    );
  }
}
