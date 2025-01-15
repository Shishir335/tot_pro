
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
export 'package:get/get.dart';
import '../../../../main.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/core/values/app_url.dart';
import '../controllers/account_delete_request_controller.dart';

class AccountDeleteRequestView extends GetView<AccountDeleteRequestController> {
  const AccountDeleteRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Account Deletion ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:   Column(
        children: [
          Image.asset("assets/images/request-callback.png",height: 200,),
          AppSpace.spaceH20,
          //Request for account deletion
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text('Request for account deletion',style: TextStyle(fontWeight: FontWeight.w800), textAlign: TextAlign.justify,),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Send a request to delete account and personally identifiable information (PII) that is stored on our system. You will receive an email to verify your request. Once the request is verified we will care of deletion your PII.',textAlign: TextAlign.justify,),
          ),
          InkWell(
            onTap: () async{
              late ApiClient   apiClient = ApiClient();
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
                apiUrl: ApiURL.accountDeleteReqUrl,
                PARAM: {},
              );

              if (response != null) {
                Helpers.snackbarForSucess(
                    titleText: 'Successful Alert',
                    bodyText: 'We have received your request. We will callback very soon.');

              } else {
                Helpers.snackbarForErorr(
                    titleText: ' Error Alert',
                    bodyText: 'Urgent Request has Field');
              }
            },
            child:
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.all(20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                    "Submit".toUpperCase(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
          ),



          const Padding(
            padding: EdgeInsets.only(left: 12,right: 12),
            child: Text('Note: Your request for account deletion will be fulfilled within 7 days.',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify,),
          ),


         ],
      ),
    );
  }
}
