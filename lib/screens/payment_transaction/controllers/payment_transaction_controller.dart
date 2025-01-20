import 'package:get/get.dart';
import '../../../main.dart';
import '../../../models/job_history_details_model.dart';
import '../../../models/payment_model.dart';
import '../../../utils/data/api_client.dart';
import '../../../utils/data/core/values/app_url.dart';

class PaymentTransactionController extends GetxController {
  final count = 0.obs;
  late ApiClient _apiClient;
  RxList<PaymentModel> paymentList =
      List<PaymentModel>.empty(growable: true).obs;
  Rx<JobHistoryDetailsModel> jobHistoryDetails = JobHistoryDetailsModel().obs;

  @override
  void onInit() {
    _apiClient = ApiClient();
    getPaymentCTR();
    super.onInit();
  }

  /// ------ payment  list
  Future getPaymentCTR() async {
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
      apiUrl: ApiURL.paymentUrl,
      PARAM: {},
    );

    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      print('PaymentTransactionController.getPaymentCTR $mapdata');
      final list = (mapdata['response']['data'] as List)
          .map((x) => PaymentModel.fromJson(x))
          .toList();
      paymentList.value = list;
    } else {
      print('HomeController.homeAllProductsCTR');
      paymentList.value = [];
    }
  }

  /// Get Job History Details  done
  /* Future getJobHistoryDetailsCTR(int id,String role) async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>> $id');
    // String? token = await localStoreSRF.getString('token');
    String? token = await localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.getEdgeWorkDetailsUrl + '$id',
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      Map<String, dynamic> info = mapdata['response']['data'];
      jobHistoryDetails.value = JobHistoryDetailsModel.fromJson(info);

      Get.toNamed(Routes.JOBHISTORYDETAILS,arguments: [
        {"first": role},
        {"second": jobHistoryDetails.value}
      ]
      );
    }
  }


  /// Get Job History delete  done
  Future getJobHistoryDeleteCTR(int id) async {
    print('HomeController.getOrderHistoryCTR delete >>>>>>>>>> $id');
    // String? token = await localStoreSRF.getString('token');
    String? token = await localStoreSRF.getString('token');
    final response = await _apiClient.connection(
      API_TYPE: 'DELETE',
      apiType: 'DELETE',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: ApiURL.deleteWorkByIdUrl + '$id',
      PARAM: {},
    );

    print('JobHistoryController.getJobHistoryDeleteCTR ${response!.statusCode.toString()}');
    if (response != null) {
      await getJobHistoryCTR();
      print('JobHistoryController.getJobHistoryDeleteCTR');
    }
  }*/
}
