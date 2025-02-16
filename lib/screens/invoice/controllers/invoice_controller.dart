import 'package:get/get.dart';
import 'package:tot_pro/models/invoicemodel.dart';
import '../../../main.dart';
import '../../../models/job_history_details_model.dart';
import '../../../models/job_history_model.dart';
import '../../../utils/data/api_client.dart';
import '../../../utils/data/core/values/app_helper.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../../../utils/routes/app_pages.dart';

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
      final Map<String, dynamic> mapdata = response.data;
      final list = (mapdata['response']['data'] as List)
          .map((x) => JobHistoryModel.fromJson(x))
          .toList();
      jobHistoryList.value = list;
    } else {
      jobHistoryList.value = [];
    }
  }

  /// Get Invoice done
  Future getInvoiceCTR() async {
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
      final Map<String, dynamic> mapdata = response.data;
      final list = (mapdata['response']['data'] as List)
          .map((x) => JobHistoryModel.fromJson(x))
          .toList();
      jobHistoryList.value = list;
    } else {
      jobHistoryList.value = [];
    }
  }

  /// Get Job History Details  done
  Future getJobHistoryDetailsCTR(int id, String role) async {
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
    String? token = localStoreSRF.getString('token');
    await _apiClient.connection(
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
    await getJobHistoryCTR();
  }

  Future<void> postPaymentCTR(Map params, InvoiceModel model) async {
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

    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'payment',
      apiType: 'POST',
      REQUEST_TYPE: '',
      REQUEST_DATA: reqData,
      apiUrl: ApiURL.paypalPaymentStoreURl,
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      PARAM: {},
    );
    if (response != null) {
      if (response.statusCode == 200) {
        Helpers.snackbarForSucess(
            titleText: 'Successful Alert'.tr,
            bodyText: 'Payment has Successful'.tr);
        await getJobHistoryCTR();
      }
    } else {
      Helpers.snackbarForErorr(
          titleText: 'Error Alert'.tr, bodyText: 'Payment has Failed'.tr);
    }
  }
}
