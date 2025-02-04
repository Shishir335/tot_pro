import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
export 'package:get/get.dart';
import '../../../models/payment_model.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/custom_widgets/custom_title_keyvalue.dart';
import '../controllers/payment_transaction_controller.dart';

class PaymentTransactionView extends GetView<PaymentTransactionController> {
  const PaymentTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: context.tr('Payment')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [fetchAPI()],
          ),
        ),
      ),
    );
  }

  fetchAPI() {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => controller.paymentList.isEmpty
              ? Center(child: Image.asset("assets/images/nodatafound.png"))
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemCount: controller.paymentList.length,
                  itemBuilder: (context, index) {
                    PaymentModel model = controller.paymentList[index];
                    return paymentCardUI(model, context);
                  },
                ),
        ));
  }

  paymentCardUI(PaymentModel model, BuildContext context) {
    return Card(
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
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTitleKeyValue(
                    titleKey: 'TID : ',
                    titleValue: model.tranid.toString(),
                  ),
                  CustomTitleKeyValue(
                      titleKey: context.tr('Date'),
                      titleValue:
                          //model.date
                          DateFormat('dd-MMM-yyyy').format(model.date)),
                  CustomTitleKeyValue(
                      titleKey: context.tr('Amount'), titleValue: model.amount),
                  AppSpace.spaceH6,
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                  //  Get.back();
                  // controller.getJobHistoryDeleteCTR(id);
                },
                child: Container(
                  alignment: Alignment.center,
                  // width: double.maxFinite,
                  height: 50,
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
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
