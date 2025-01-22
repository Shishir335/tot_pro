import 'package:get/get.dart';
import '../../../utils/data/api_client.dart';

class TransactionController extends GetxController {
  final count = 0.obs;
  late ApiClient _apiClient;
  //RxList<JobHistoryModel> jobHistoryList = List<JobHistoryModel>.empty(growable: true).obs;
  //Rx<JobHistoryDetailsModel> jobHistoryDetails = JobHistoryDetailsModel().obs;

  @override
  void onInit() {
    _apiClient = ApiClient();
    // getJobHistoryCTR();
    super.onInit();
  }

/*
  /// Get Job History done done
  Future getJobHistoryCTR() async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>>>>>>>');
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
      apiUrl: ApiURL.getEdgeWorksUrl,
      PARAM: {},
    );

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      print('HomeController.getDonationRecordCTR ${mapdata}');
      final list = (mapdata['response']['data'] as List).map((x) =>
          JobHistoryModel.fromJson(x)).toList();
      jobHistoryList.value = list;

    } else {
      print('HomeController.homeAllProductsCTR');
      jobHistoryList.value = [];
    }

    print('HomeController lng :: ${jobHistoryList.length}');
    print('HomeController history :: ${jobHistoryList.toJson()}');
  }

  /// Get Job History Details  done
  Future getJobHistoryDetailsCTR(int id,String role) async {
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
*/

  /// Get Job History delete  done
  /* Future getJobHistoryDeleteCTR(int id) async {
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
