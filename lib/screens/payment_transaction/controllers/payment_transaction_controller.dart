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
      final list = (mapdata['response']['data'] as List)
          .map((x) => PaymentModel.fromJson(x))
          .toList();
      paymentList.value = list;
    } else {
      paymentList.value = [];
    }
  }
}
