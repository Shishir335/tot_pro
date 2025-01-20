import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/invoicemodel.dart';
import 'package:tot_pro/models/transactionmodel.dart';
import '../../../main.dart';
import '../../../models/completed_work_model.dart';
import '../../../models/job_history_details_model.dart';
import '../../../models/job_history_model.dart';
import '../../../utils/data/api_client.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../../../utils/routes/app_pages.dart';

class JobHistoryController extends GetxController {
  final count = 0.obs;
  late ApiClient _apiClient;
  RxList<JobHistoryModel> jobHistoryList =
      List<JobHistoryModel>.empty(growable: true).obs;

  RxList<CompletedWorkModel> completedWorkList =
      List<CompletedWorkModel>.empty(growable: true).obs;

  TextEditingController controllerFilter = TextEditingController();

  RxList<JobHistoryModel> searchResult1 =
      List<JobHistoryModel>.empty(growable: true).obs;

  RxList<InvoiceModel> invoiceList =
      List<InvoiceModel>.empty(growable: true).obs;
  RxList<TransactionModel> transactionList =
      List<TransactionModel>.empty(growable: true).obs;
  Rx<JobHistoryDetailsModel> jobHistoryDetails = JobHistoryDetailsModel().obs;

  Rx<InvoiceModel> invoice = InvoiceModel().obs;

  @override
  void onInit() {
    _apiClient = ApiClient();
    getJobHistoryCTR();
    super.onInit();
  }

  /// Search Job History
  ///

  onSearchTextChanged(String text) async {
    print('Check >>>> $text');
    searchResult1.clear();
    if (text.isEmpty) {
      return;
    }

    for (var searchValue in jobHistoryList) {
      if (searchValue.orderid!.toLowerCase().contains(text.toLowerCase())) {
        searchResult1.add(searchValue);
      }
    }
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

  /// Get Job Completed Details  done New Task
  Future getJobCompletedDetailsCTR(int id) async {
    print('HomeController.getOrderHistoryCTR >>>>>>>>>> $id');
    print(
        'HomeController.getOrderHistoryCTR >>>>>>>>>> ${'${ApiURL.getCompleteWorkDetailsUrl}$id'}');
    // String? token = await localStoreSRF.getString('token');
    String? token = localStoreSRF.getString('token');
    final response = await _apiClient.connectionWork(
      API_TYPE: 'GET',
      apiType: 'GET',
      REQUEST_TYPE: '',
      REQUEST_DATA: {},
      customheader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      apiUrl: '${ApiURL.getCompleteWorkDetailsUrl}$id',
      PARAM: {},
    );

    /*if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      Map<String, dynamic> info = mapdata['response']['data'];
      completedWorkList.value = CompletedWorkModel.fromJson(info);
d
      Get.toNamed(Routes.workCompleteDetails,arguments: [
        {"first": 'role'},
        {"second": completedWorkList.value}
      ]
      );
    }*/

    if (response != null) {
      print('HomeController.homeAllProductsCTR');
      final Map<String, dynamic> mapdata = response.data;
      print('HomeController.getDonationRecordCTR $mapdata');
      final list = (mapdata['response']['data'] as List)
          .map((x) => CompletedWorkModel.fromJson(x))
          .toList();
      completedWorkList.value = list;

      Get.toNamed(Routes.workCompleteDetails, arguments: [
        {"orderId": id.toString()},
        {"CompletedList": completedWorkList.value}
      ]);
    } else {
      print('HomeController.homeAllProductsCTR');
      completedWorkList.value = [];
    }
  }

  /// Get Job History Invoice  done
  Future getJobHistoryInvoiceCTR(int id, jobId) async {
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
      apiUrl: '${ApiURL.getInvoiceUrl}$id',
      PARAM: {},
    );

    print('invoice Url :: ${ApiURL.getInvoiceUrl}  $id');
    if (response != null) {
      final Map<String, dynamic> mapdata = response.data;
      print('JobHistoryController.getJobHistoryInvoiceCTR $mapdata');
      print('JobHistoryController ?? ${mapdata['response']['data']}');
      final list = (mapdata['response']['data'] as List)
          .map((x) => InvoiceModel.fromJson(x))
          .toList();
      invoiceList.value = list;
      print('invoice lng :: ${invoiceList.length}');
      print('invoice lng :: ${invoiceList[0].toJson()}');
      //   invoice.value.jobId=jobId;
      Get.toNamed(Routes.Invoice, arguments: [invoiceList, jobId]);
      //  print(invoice.value.jobId);
    } else {
      print('HomeController.homeAllProductsCTR');
      invoiceList.value = [];
    }
  }

  /// Get Job History Transaction  done
  Future getJobHistoryTransactionCTR(int id, jobId) async {
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
      apiUrl: '${ApiURL.getTransactionsUrl}$id',
      PARAM: {},
    );

    if (response != null) {
      print('JobHistoryController.getJobHistoryTransactionCTR');
      final Map<String, dynamic> mapdata = response.data;

      final list = (mapdata['response']['data'] as List)
          .map((x) => TransactionModel.fromJson(x))
          .toList();
      transactionList.value = list;
      print('transactionList :: ${transactionList.value}');
      print('tn lng :: ${transactionList.length}');
      Get.toNamed(Routes.Transaction, arguments: [transactionList, jobId]);
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
}
