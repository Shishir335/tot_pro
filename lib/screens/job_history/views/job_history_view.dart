import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Job History',
          style: TextStyle(color: Colors.white),
        ),
      ),
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
              //  Text('search'),
              searchDonation(),
              //   fetchAPI(),
              fetchDonationRecord(),
            ],
          ),
        ),
      ),
    );
  }

  /// Search

  /// Search Donation
  searchDonation() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(left: 10, top: 5, bottom: 10, right: 10),
      //color: Colors.grey,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 20),
        leading: const Icon(
          Icons.search,
          color: Colors.black,
          size: 20,
        ),
        horizontalTitleGap: 5.0,
        title: TextField(
          style: const TextStyle(color: Colors.black),
          controller: controller.controllerFilter,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              hintText: 'Search',
              border: InputBorder.none),
          onChanged: controller.onSearchTextChanged,
        ),
        trailing: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.cancel),
          onPressed: () {
            controller.controllerFilter.clear();
            controller.onSearchTextChanged('');
          },
        ),
      ),
    );
  }

  fetchAPI() {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => controller.jobHistoryList.isEmpty
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
                    //model = controller.JobHistoryModel[index];
                    return jobCardUI(model);
                  },
                ),
        ));
  }

  fetchDonationRecord() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Obx(
        () => controller.jobHistoryList.isEmpty
            ? Center(child: Image.asset("assets/images/nodatafound.png"))
            : controller.searchResult1.isNotEmpty ||
                    controller.controllerFilter.text.isNotEmpty
                ? ListView.separated(
                    //  reverse:true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      JobHistoryModel model = controller.searchResult1[index];
                      //  print('HomePage.build ${model.amount}');

                      return Container();
                    },
                    itemCount: controller.searchResult1.length,
                    itemBuilder: (context, index) {
                      JobHistoryModel model = controller.searchResult1[index];
                      return jobCardUI(model);
                    },
                  )
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container();
                    },
                    itemCount: controller.jobHistoryList.length,
                    itemBuilder: (context, index) {
                      JobHistoryModel model = controller.jobHistoryList[index];
                      //model = controller.JobHistoryModel[index];
                      return jobCardUI(model);
                    },
                  ),
      ),
    );
  }

  jobCardUI(JobHistoryModel model) {
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
        print('JobHistoryView.jobCardUI');
        controller.getJobHistoryDetailsCTR(model.id ?? -1, 'show');
      },
      child: Card(
        elevation: 0.0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        titleKey: 'Job Id',
                        titleValue: model.orderid.toString()),
                    CustomTitleKeyValue(
                        titleKey: 'Date',
                        titleValue: DateFormat('dd-MMM-yyyy')
                            .format(model.date ?? DateTime.now())),

                    /* CustomTitleKeyValue(
                        titleKey: 'Status  ',
                        titleValue: model.status.toString()),
                  */
                    CustomTitleKeyValue(
                        titleKey: 'Name ', titleValue: model.name.toString()),
                    CustomTitleKeyValue(
                        titleKey: 'Email', titleValue: model.email.toString()),
                    /* CustomTitleKeyValue(
                        titleKey: 'Status',
                        titleValue: statusTitle
                    ),*/
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
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          // width: 100,
                          child: Text(' $statusTitle',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        AppSpace.spaceW4,
                        model.status == '3'
                            ? InkWell(
                                onTap: () {
                                  controller.getJobCompletedDetailsCTR(
                                      model.id ?? -1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: model.status == '1'
                                          ? Colors.blue
                                          : model.status == '2'
                                              ? Colors.green
                                              : model.status == '3'
                                                  ? Colors.green
                                                  : Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  // width: 100,
                                  child: const Text(
                                    'Work Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    /* Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 5,
                      child: Text(
                        'Status',

                        maxLines: 1,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 50,
                      color: model.status=='1'? Colors.blue:model.status=='2'? Colors.green:model.status=='3'?Colors.green:Colors.red,
                      child: Text(' $statusTitle', style:  TextStyle(


                          fontWeight: FontWeight.w400,
                        color: Colors.white

                      )),
                    ),),

                ],
              ),
            ),*/

                    /*  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: (){},
                              //controller.getJobHistoryDetailsCTR(model.id,'show'),
                              child: Container(
                                //    width: double.maxFinite,
                                height: 50,
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Invoice".toUpperCase(),
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Icon(Icons.inventory_outlined,color: Colors.white,)
                                  ],
                                ),
                              ),
                            ),
                        ),
                        Expanded(
                          flex: 4,
                          child:
                          InkWell(
                              onTap: (){},
                                  //controller.getJobHistoryDetailsCTR(model.id,'show'),
                              child: Container(
                                //    width: double.maxFinite,
                                height: 50,
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Invoice".toUpperCase(),
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Icon(Icons.inventory_outlined,color: Colors.white,)
                                  ],
                                ),
                              ),
                          ),
                        )

                      ],
                    ),
                  ),
      */

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
                            dashGapRadius: 0.0,
                          ),
                    AppSpace.spaceH10,
                    model.invoice!.isEmpty || model.invoice == []
                        ? Container()
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //   model.invoice=='' ||model.invoice==null?Container():
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    print('order Id :: ${model.orderid}');
                                    controller.getJobHistoryInvoiceCTR(
                                        model.id ?? -1, model.orderid);
                                  },
                                  //controller.getJobHistoryDetailsCTR(model.id,'edit'),

                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Invoice'.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),

                              model.transactions!.isEmpty ||
                                      model.transactions == []
                                  ? Container()
                                  : Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          print(
                                              'JobHistoryView.jobCardUI Trnsaction');
                                          controller
                                              .getJobHistoryTransactionCTR(
                                                  model.id ?? -1,
                                                  model.orderid);
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'Transactions'.toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
                            ],
                          ),
                  ],
                ),
              ),
              model.invoice != null || model.transactions!.isNotEmpty
                  ? Expanded(
                      child: InkWell(
                        onTap: () => controller.getJobHistoryDetailsCTR(
                            model.id ?? -1, 'show'),
                        child: Container(
                          alignment: Alignment.center,
                          //    width: double.maxFinite,
                          height: 50,
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(10),

                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: PopupMenuButton<String>(
                        iconColor: Colors.red,
                        iconSize: 30,
                        onSelected: (v) {
                          choiceAction(v, model);
                        },
                        itemBuilder: (BuildContext context) {
                          return Action.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(child: Icon(Icons.person)),
            )*/
                      ),

                      /* Container(
                height: 150,
                child:


                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                     Expanded(

                      child: InkWell(
                        onTap: ()=> controller.getJobHistoryDetailsCTR(model.id,'show'),
                        child: Container(
                          //    width: double.maxFinite,
                          height: 50,
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:   Icon(Icons.remove_red_eye,color: Colors.white,)
                          ,
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: ()=> controller.getJobHistoryDetailsCTR(model.id,'edit'),

                        child: Container(
                          //   width: double.maxFinite,
                            height: 50,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Icon(Icons.edit,color: Colors.white,)
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () {

                          openDialog(model.id);
                        },
                        child: Container(
                          // width: double.maxFinite,
                          height: 50,
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.delete_forever,color: Colors.white,),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
           */
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice, JobHistoryModel model) {
    print('choice :$choice');
    if (choice == 'Job Details') {
      controller.getJobHistoryDetailsCTR(model.id ?? -1, 'show');
    } else if (choice == 'Delete Job') {
      print('Delete');
      openDialog(model.id ?? -1);
    } else {
      controller.getJobHistoryDetailsCTR(model.id ?? -1, 'edit');
      // Edit
      // Get.toNamed(Routes.CHANGEPASSWORD);
    }
  }

  /// Job remove Alert
  openDialog(int id) {
    Get.dialog(
      AlertDialog(
        icon: const Icon(Icons.delete_forever),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are Yor Sure?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AppSpace.spaceH6,
            Text(
              'Do you want to remove job?',
              style: TextStyle(fontSize: 14),
            ),
            AppSpace.spaceH20,
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  // width: double.maxFinite,
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () async {
                  Get.back();
                  controller.getJobHistoryDeleteCTR(id);
                },
                child: Container(
                  alignment: Alignment.center,
                  // width: double.maxFinite,
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}

class Action {
  static const String fund = 'Fund';
//  static const String Settings = 'Settings';
  static const String SignOut = 'Job Details';

  static const List<String> choices = <String>[
    'Job Details',
    'Edit',
    'Delete Job',
  ];
}
