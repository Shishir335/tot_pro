import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/core/values/app_url.dart';
import 'package:tot_pro/models/invoicemodel.dart';
import 'package:intl/intl.dart';
export 'package:get/get.dart';
import '../../../../paypal_payment/payment_services.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/custom_widgets/custom_title_keyvalue.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    List<InvoiceModel> invoices = Get.arguments[0];
    print('invoice lng >>  :: ${invoices.length}');
    print('invoice jobId >>  :: ${Get.arguments[1]}');
    String jobId = '';
    jobId = Get.arguments[1];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Invoice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [fetchAPI(invoices, jobId)],
          ),
        ),
      ),
    );
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
                //model = controller.JobHistoryModel[index];
                return invoiceCardUI(context, jobId, model);
              },
            ),
      //)
    );
  }

  invoiceCardUI(BuildContext context, jobId, InvoiceModel model) {
    print('invoice status :: ${model.status}');
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
                      titleKey: 'Job Id', titleValue: jobId.toString()),
                  CustomTitleKeyValue(
                      titleKey: 'Date',
                      titleValue: DateFormat('dd-MMM-yyyy')
                          .format(model.date ?? DateTime.now())),
                  CustomTitleKeyValue(
                      titleKey: 'Invoice ID: ',
                      titleValue: model.invoiceid.toString()),
                  CustomTitleKeyValue(
                      titleKey: 'Amount', titleValue: model.amount.toString()),
                  AppSpace.spaceH10,

                  ///------------ Image OR  PDF ------------
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          String path = ApiURL.globalUrl + model.img.toString();
                          fullScreen(path);
                          print('InvoiceView.invoiceCardUI Full Screen');
                        },
                        child: Container(
                          // width: 120,
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.center,
                          /*decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),*/
                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.network(
                                    '${ApiURL.globalUrl + model.img.toString()}',
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
/*
                  model.status=='0'?
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                            "Paid".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                  ):*/
                  InkWell(
                    onTap: () {
                      print('invoice id :: ${model.toJson()}');
                      // print('invoice id :: ${model.invoice_id}');

                      /// todo list paypal
                      /* print('amount ${model}');
                      print('amount ${model.id.toString()}');
                      print('workId ${model.workId.toString()}');
*/
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckoutView(
                          sandboxMode: false,
                          clientId: PaypalServices.clientId,
                          secretKey: PaypalServices.secret,
                          transactions: [
                            {
                              "amount": {
                                "total": model.amount.toString(),
                                "currency": "GBP",
                                "details": {
                                  "subtotal": model.amount.toString(),
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Apple",
                                    "quantity": 1,
                                    "price": model.amount.toString(),
                                    "currency": "GBP"
                                  },
                                ],

                                // Optional
                                //   "shipping_address": {
                                //     "recipient_name": "Tharwat samy",
                                //     "line1": "tharwat",
                                //     "line2": "",
                                //     "city": "tharwat",
                                //     "country_code": "EG",
                                //     "postal_code": "25025",
                                //     "phone": "+00000000",
                                //     "state": "ALex"
                                //  },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            //  print('InvoiceView.invoiceCardUI');
                            // log("onSuccess: $params");
                            // print('InvoiceView.invoiceCardUI after');

                            Navigator.pop(context);
                            controller.postPaymentCTR(params, model);
                            Navigator.pop(context);
                          },
                          onError: (error) {
                            log("onError: $error");
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            print('cancelled:');
                            Navigator.pop(context);
                          },
                        ),
                      ));
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "Pay".toUpperCase(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )),
                    ),
                  ),
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
                ),
              ),
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

  fullScreen(String imagePath) {
    return Get.dialog(
      AlertDialog(
        title: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.close)),
        content: Image.network(imagePath),
      ),
    );
  }
}
