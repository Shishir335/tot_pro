import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tot_pro/components/app_bar.dart';
export 'package:get/get.dart';
import '../../../models/job_history_model.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/custom_widgets/custom_title_keyvalue.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/job_history_controller.dart';

class JobHistoryView extends GetView<JobHistoryController> {
  const JobHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const CustomAppBar(title: 'Job History'),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      searchDonation(context),
                      fetchDonationRecord()
                    ]))));
  }

  /// Search

  /// Search Donation
  searchDonation(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)),
            color: Colors.white),
        margin: const EdgeInsets.only(left: 10, top: 5, bottom: 10, right: 10),
        child: ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            leading: const Icon(Icons.search, color: Colors.black, size: 20),
            horizontalTitleGap: 5.0,
            title: TextField(
                style: const TextStyle(color: Colors.black),
                controller: controller.controllerFilter,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: context.tr('Search'),
                    border: InputBorder.none),
                onChanged: controller.onSearchTextChanged),
            trailing: IconButton(
                color: Colors.black,
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  controller.controllerFilter.clear();
                  controller.onSearchTextChanged('');
                })));
  }

  fetchAPI() {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Obx(() => controller.jobHistoryList.isEmpty
            ? Center(child: Image.asset("assets/images/nodatafound.png"))
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Container();
                },
                itemCount: controller.jobHistoryList.length,
                itemBuilder: (context, index) {
                  JobHistoryModel model = controller.jobHistoryList[index];
                  return jobCardUI(model, context);
                })));
  }

  fetchDonationRecord() {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Obx(() => controller.jobHistoryList.isEmpty
            ? Center(child: Image.asset("assets/images/nodatafound.png"))
            : controller.searchResult1.isNotEmpty ||
                    controller.controllerFilter.text.isNotEmpty
                ? ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container();
                    },
                    itemCount: controller.searchResult1.length,
                    itemBuilder: (context, index) {
                      JobHistoryModel model = controller.searchResult1[index];
                      return jobCardUI(model, context);
                    })
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container();
                    },
                    itemCount: controller.jobHistoryList.length,
                    itemBuilder: (context, index) {
                      JobHistoryModel model = controller.jobHistoryList[index];
                      return jobCardUI(model, context);
                    })));
  }

  jobCardUI(JobHistoryModel model, BuildContext context) {
    String statusTitle = '';
    if (model.status == '1') {
      statusTitle = 'New';
    } else if (model.status == '2') {
      statusTitle = 'In progress';
    } else if (model.status == '3') {
      statusTitle = 'Completed';
    } else {
      statusTitle = 'Cancelled';
    }
    return InkWell(
        onTap: () {
          controller.getJobHistoryDetailsCTR(model.id ?? -1, 'show');
        },
        child: Card(
            elevation: 0.0,
            color: Colors.white,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 10,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTitleKeyValue(
                                    titleKey: context.tr('Job Id'),
                                    titleValue: model.orderid.toString()),
                                CustomTitleKeyValue(
                                    titleKey: context.tr('Date'),
                                    titleValue: DateFormat('dd-MMM-yyyy')
                                        .format(model.date ?? DateTime.now())),
                                CustomTitleKeyValue(
                                    titleKey: context.tr('Name'),
                                    titleValue: model.name.toString()),
                                CustomTitleKeyValue(
                                    titleKey: context.tr('Email'),
                                    titleValue: model.email.toString()),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: model.status == '1'
                                                ? Colors.blue
                                                : model.status == '2'
                                                    ? Colors.green
                                                    : model.status == '3'
                                                        ? Colors.green
                                                        : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Text(' $statusTitle',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))),
                                    AppSpace.spaceW4,
                                    model.status == '3'
                                        ? InkWell(
                                            onTap: () {
                                              controller
                                                  .getJobCompletedDetailsCTR(
                                                      model.id ?? -1);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: model.status == '1'
                                                        ? Colors.blue
                                                        : model.status == '2'
                                                            ? Colors.green
                                                            : model.status ==
                                                                    '3'
                                                                ? Colors.green
                                                                : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    context.tr('Work Details'),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))))
                                        : Container(),
                                  ],
                                ),
                                AppSpace.spaceH10,
                                model.invoice == '' || model.invoice == null
                                    ? Container()
                                    : const DottedLine(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.center,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: Colors.black,
                                        dashRadius: 0.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0),
                                AppSpace.spaceH10,
                                model.invoice!.isEmpty || model.invoice == []
                                    ? Container()
                                    : Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .getJobHistoryInvoiceCTR(
                                                              model.id ?? -1,
                                                              model.orderid);
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        margin:
                                                            const EdgeInsets.all(
                                                                2),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade200,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                        child: Text(
                                                            context
                                                                .tr('Invoice')
                                                                .toUpperCase(),
                                                            style: const TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold))))),
                                            model.transactions!.isEmpty ||
                                                    model.transactions == []
                                                ? Container()
                                                : Expanded(
                                                    child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .getJobHistoryTransactionCTR(
                                                                  model.id ??
                                                                      -1,
                                                                  model
                                                                      .orderid);
                                                        },
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    10),
                                                            margin: const EdgeInsets.all(
                                                                2),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10)),
                                                            child: Text(context.tr('Transactions').toUpperCase(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight: FontWeight.bold)))))
                                          ])
                              ])),
                      model.invoice != null || model.transactions!.isNotEmpty
                          ? Expanded(
                              child: InkWell(
                                  onTap: () =>
                                      controller.getJobHistoryDetailsCTR(
                                          model.id ?? -1, 'show'),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      margin: const EdgeInsets.all(2),
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(Icons.remove_red_eye,
                                          color: Colors.red))))
                          : Expanded(
                              child: PopupMenuButton<String>(
                                  iconColor: Colors.red,
                                  iconSize: 30,
                                  onSelected: (v) {
                                    choiceAction(v, model, context);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return Action.choices.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  }))
                    ]))));
  }

  void choiceAction(
      String choice, JobHistoryModel model, BuildContext context) {
    if (choice == 'Job Details') {
      controller.getJobHistoryDetailsCTR(model.id ?? -1, 'show');
    } else if (choice == 'Delete Job') {
      openDialog(model.id ?? -1, context);
    } else {
      controller.getJobHistoryDetailsCTR(model.id ?? -1, 'edit');
    }
  }

  /// Job remove Alert
  openDialog(int id, BuildContext context) {
    Get.dialog(AlertDialog(
        icon: const Icon(Icons.delete_forever),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr('Are Yor Sure?'),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            AppSpace.spaceH6,
            Text(context.tr('Do you want to remove job?'),
                style: const TextStyle(fontSize: 14)),
            AppSpace.spaceH20
          ],
        ),
        actions: [
          Row(children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(context.tr('Cancel'),
                            style: const TextStyle(color: Colors.white))))),
            Expanded(
                child: InkWell(
                    onTap: () async {
                      Get.back();
                      controller.getJobHistoryDeleteCTR(id);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(context.tr('Ok'),
                            style: const TextStyle(color: Colors.white)))))
          ])
        ]));
  }
}

class Action {
  static const String fund = 'Fund';
  static const String SignOut = 'Job Details';

  static const List<String> choices = <String>[
    'Job Details',
    'Edit',
    'Delete Job',
  ];
}
