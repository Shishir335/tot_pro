import 'package:get/get.dart';
import 'package:tot_pro/models/invoicemodel.dart';
import '../../../../main.dart';
import '../../../../models/job_history_details_model.dart';
import '../../../../models/job_history_model.dart';
import '../../../data/api_client.dart';
import '../../../data/core/values/app_helper.dart';
import '../../../data/core/values/app_url.dart';
import '../../../routes/app_pages.dart';

class InvoiceController extends GetxController {
  final count = 0.obs;
  late ApiClient _apiClient;
  RxList<JobHistoryModel> jobHistoryList =
      List<JobHistoryModel>.empty(growable: true).obs;
  Rx<JobHistoryDetailsModel> jobHistoryDetails = JobHistoryDetailsModel().obs;

  @override
  void onInit() {
    _apiClient = ApiClient();
    getJobHistoryCTR();
    super.onInit();
  }

  /// Get Job History done done
  Future getJobHistoryCTR() async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>>>>>>>');
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
      apiUrl: ApiURL.getEdgeWorksUrl,
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      //print('HomeController.getDonationRecordCTR ${mapdata}');
      final list = (mapdata['response']['data'] as List)
          .map((x) => JobHistoryModel.fromJson(x))
          .toList();
      jobHistoryList.value = list;
    } else {
      print('HomeController.homeAllProductsCTR');
      jobHistoryList.value = [];
    }

    print('HomeController lng :: ${jobHistoryList.length}');
    //print('HomeController history :: ${jobHistoryList.toJson()}');
  }

  /// Get Invoice done
  Future getInvoiceCTR() async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>>>>>>>');
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
      apiUrl: ApiURL.getEdgeWorksUrl,
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      print('HomeController.getDonationRecordCTR $mapdata');
      final list = (mapdata['response']['data'] as List)
          .map((x) => JobHistoryModel.fromJson(x))
          .toList();
      jobHistoryList.value = list;
    } else {
      print('HomeController.homeAllProductsCTR');
      jobHistoryList.value = [];
    }

    print('HomeController lng :: ${jobHistoryList.length}');
    print('HomeController history :: ${jobHistoryList.toJson()}');
  }

  /// Get Job History Details  done
  Future getJobHistoryDetailsCTR(int id, String role) async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>> $id');
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
      apiUrl: '${ApiURL.getEdgeWorkDetailsUrl}$id',
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      Map<String, dynamic> info = mapdata['response']['data'];
      jobHistoryDetails.value = JobHistoryDetailsModel.fromJson(info);

      Get.toNamed(Routes.JOBHISTORYDETAILS, arguments: [
        {"first": role},
        {"second": jobHistoryDetails.value}
      ]);
    }
  }

  /// Get Job History delete  done
  Future getJobHistoryDeleteCTR(int id) async {
    print('HomeController.getOrderHistoryCTR delete >>>>>>>>>> $id');
    // String? token = await localStoreSRF.getString('token');
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'DELETE',
      apiType: 'DELETE',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: '${ApiURL.deleteWorkByIdUrl}$id',
      PARAM: {},
    );

    print(
        'JobHistoryController.getJobHistoryDeleteCTR ${response!.statusCode.toString()}');
    await getJobHistoryCTR();
    print('JobHistoryController.getJobHistoryDeleteCTR');
  }

  Future<void> postPaymentCTR(Map params, InvoiceModel model) async {
    print(' params :: $params');
    String paymentId = params['data']['id'];
    String paypalState = params['data']['state'];
    String paypalMail = params['data']['payer']['payer_info']['email'];
    String paypalId = params['data']['payer']['payer_info']['payer_id'];

    Map<String, String> reqData = {
      "amount": model.amount.toString(),
      "invoice_id": model.id.toString(),
      "work_id": model.workId.toString(),
      "payment_id": paymentId,
      "payer_id": paypalId,
      "payer_email": paypalMail,
      "state": paypalState,
    };

    // print(data);

    print(reqData);

    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'payment',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: reqData
      /*{
        "amount": "100",
        "work_id": "97",
        "payment_id": "PAYID-MY3O7CA2SX28349FC263524U",
        "payer_id": "Z54664",
        "payer_email": "sb-uxexq26090830@personal.example.com",
        "state": "approved"
      }*/
      ,
      apiUrl: ApiURL.paypalPaymentStoreURl,
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      PARAM: {},
    );
    if (response != null) {
      final Map<String, dynamic> myresponse = response.data;
      print(
          'InvoiceController.postPaymentCTR ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        Helpers.snackbarForSucess(
            titleText: 'Successful Alert', bodyText: 'Payment has Successful');
        print('InvoiceController.postPaymentCTR ');
        await getJobHistoryCTR();

        //  return true;
      }
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Error Alert', bodyText: 'Payment has Failed');
      //return false;
    }
    //return false;
  }
}
