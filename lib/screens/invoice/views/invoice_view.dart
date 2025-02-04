import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/models/invoicemodel.dart';
export 'package:get/get.dart';
import '../../../utils/paypal_payment/payment_services.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/custom_widgets/custom_title_keyvalue.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    List<InvoiceModel> invoices = Get.arguments[0];
    String jobId = '';
    jobId = Get.arguments[1];

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustomAppBar(title: context.tr('Invoice')),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [fetchAPI(invoices, jobId)]))));
  }

  fetchAPI(List<InvoiceModel> invoices, jobId) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: invoices.isEmpty
          ? Center(child: Image.asset("assets/images/nodatafound.png"))
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Container();
              },
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                InvoiceModel model = invoices[index];
                return invoiceCardUI(context, jobId, model);
              },
            ),
      //)
    );
  }

  invoiceCardUI(BuildContext context, jobId, InvoiceModel model) {
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
                                titleKey: 'Job Id',
                                titleValue: jobId.toString()),
                            CustomTitleKeyValue(
                                titleKey: 'Date',
                                titleValue: DateFormat('dd-MMM-yyyy')
                                    .format(model.date ?? DateTime.now())),
                            CustomTitleKeyValue(
                                titleKey: 'Invoice ID: ',
                                titleValue: model.invoiceid.toString()),
                            CustomTitleKeyValue(
                                titleKey: 'Amount',
                                titleValue: model.amount.toString()),
                            AppSpace.spaceH10,

                            ///------------ Image OR  PDF ------------
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(5),
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    String path =
                                        ApiURL.globalUrl + model.img.toString();
                                    fullScreen(path);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.network(
                                              ApiURL.globalUrl +
                                                  model.img.toString(),
                                              alignment: Alignment.center,
                                              fit: BoxFit.fitWidth,
                                              height: 150,
                                              width: double.infinity,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AppSpace.spaceH10,
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaypalCheckoutView(
                                      sandboxMode: false,
                                      clientId: PaypalServices.clientId,
                                      secretKey: PaypalServices.secret,
                                      transactions: [
                                        {
                                          "amount": {
                                            "total": model.amount.toString(),
                                            "currency": "GBP",
                                            "details": {
                                              "subtotal":
                                                  model.amount.toString(),
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description":
                                              "The payment transaction description.",
                                          "item_list": {
                                            "items": [
                                              {
                                                "name": "Apple",
                                                "quantity": 1,
                                                "price":
                                                    model.amount.toString(),
                                                "currency": "GBP"
                                              },
                                            ],
                                          }
                                        }
                                      ],
                                      note: context.tr(
                                          "Contact us for any questions on your order."),
                                      onSuccess: (Map params) async {
                                        Navigator.pop(context);
                                        controller.postPaymentCTR(
                                            params, model);
                                        Navigator.pop(context);
                                      },
                                      onError: (error) {
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ));
                                },
                                child: Container(
                                    width: double.maxFinite,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                            context.tr("Pay").toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white))))),
                            AppSpace.spaceH6
                          ]))
                ])));
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              AppSpace.spaceH6,
              Text(context.tr('Do you want to remove job?'),
                  style: TextStyle(fontSize: 14)),
              AppSpace.spaceH20
            ]),
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
                            style: TextStyle(color: Colors.white))))),
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
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(context.tr('Ok'),
                            style: TextStyle(color: Colors.white)))))
          ])
        ]));
  }

  fullScreen(String imagePath) {
    return Get.dialog(AlertDialog(
        title: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.close)),
        content: Image.network(imagePath)));
  }
}
